//
//  MusicManager.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import MusicKit
import SwiftUI
import Combine

class MusicConfig: ObservableObject {
    var item: MusicItem
    var play: Bool
    
    init(item: MusicItem, play: Bool = false) {
        self.item = item
        self.play = play
    }
}

class MusicManager: ObservableObject {
    
    @Published var musicItem: MusicConfig?
    @Published var songTitle: String = ""
    @Published var musicDuration: TimeInterval = 0.0
    @Published var songIconUrl: URL?
    @Published var status: MusicPlayer.PlaybackStatus = .stopped
    @Published var playbackTime: TimeInterval = 0.0
    
    private var timer: AnyCancellable?
    
    private func resetMusic() {
        musicDuration = 0
        playbackTime = 0
        status = .stopped
    }
    
    static func getAuthorizationStatus() async -> MusicAuthorization.Status {
        return await MusicAuthorization.request()
    }
    
    private var store = Set<AnyCancellable>()
    private var mediaPlayer: ApplicationMusicPlayer {
        ApplicationMusicPlayer.shared
    }
    
    func startObserving() {
        $musicItem
            .compactMap { $0 }
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .removeDuplicates { $0.item.id == $1.item.id }
            .compactMap { config -> (Song, Bool)? in
                guard let song = config.item as? Song else { return nil }
                return (song, config.play)
            }
            .sink { [weak self] song, play in
                guard let self = self else { return }
                self.resetMusic()
                self.playbackTime = 0
                self.songTitle = song.title
                self.songIconUrl = song.artwork?.url(width: 50, height: 50)
                self.musicDuration = song.duration ?? 0
                self.mediaPlayer.queue = [song]
                if play {
                    Task {
                        try await self.start()
                    }
                }
            }
            .store(in: &store)
    }
    
    private func setupTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.playbackTime = self.mediaPlayer.playbackTime
                if self.playbackTime >= self.musicDuration {
                    self.status = .stopped
                    self.timer?.cancel()
                }
            }
    }
    
    func getSong(searchString: String = "Hello") async -> Song? {
        let task = Task { () -> Song? in
            var req1 = MusicCatalogSearchRequest(term: searchString, types: [Station.self, Song.self, Album.self, RadioShow.self])
            req1.limit = 25
            let resp1 = try await req1.response()
            
            guard let song = resp1.songs.first else {
                print("Song not found in ", resp1.songs, searchString)
                return nil
            }
            return song
        }
        guard let song = try? await task.result.get() else {
            return nil
        }
        return song
    }
    
    func getRecomendations() {
        Task {
            let request = MusicPersonalRecommendationsRequest()
            let response = try await request.response()
            
            print(response.recommendations)
        }
    }
    
    func getLibrary() {
        Task {
            var request = MusicLibraryRequest<Song>()
            request.sort(by: \.libraryAddedDate, ascending: false)
            let response = try await request.response()
            
            print(response.items)
        }
    }
    
    func start() async throws {
        try await mediaPlayer.prepareToPlay()
        try await mediaPlayer.play()
        self.status = .playing
        setupTimer()
    }
    
    func pause() {
        self.status = .paused
        mediaPlayer.pause()
    }
    
    func skipTo(_ time: TimeInterval) {
        mediaPlayer.playbackTime = time
    }
    
    func stopPlaying() {
        mediaPlayer.queue.entries = .init()
        mediaPlayer.stop()
        status = .stopped
    }
}


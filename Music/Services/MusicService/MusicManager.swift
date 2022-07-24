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
    @Published var playbackTime: TimeInterval = 0.0
    @Published var songIconUrl: URL?
    @Published var status: MusicPlayer.PlaybackStatus = .stopped
    @Published var fetchNext = PassthroughSubject<Song, Never>()
    
    private var store = Set<AnyCancellable>()
    private var mediaPlayer = ApplicationMusicPlayer.shared
    
    static func getAuthorizationStatus() async -> MusicAuthorization.Status {
        return await MusicAuthorization.request()
    }
    
    func startObserving() {
        $musicItem
            .compactMap { $0 }
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .compactMap { config -> (Song, Bool)? in
                guard let song = config.item as? Song else { return nil }
                return (song, config.play)
            }
            .sink { [weak self] song, play in
                guard let self = self else { return }
                self.songTitle = song.title
                self.songIconUrl = song.artwork?.url(width: 50, height: 50)
                self.musicDuration = song.duration ?? 0
                if play {
                    Task {
                        try await self.start()
                    }
                }
            }
            .store(in: &store)
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
        status = .playing
    }
    
    func pause() {
        status = .paused
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
    
    var currentList = [Song]()
    
    func playSongs(_ songs: [Song]) throws {
        if songs.isEmpty { return }
        currentList = songs
        putMultipleSongs(songs)
        let config = MusicConfig(item: songs[0], play: true)
        musicItem = config

        // TODO: - Fix this SHIT, mb MusicKit problem
        mediaPlayer.queue.objectWillChange
            .debounce(for: 0.01, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let entry = self?.mediaPlayer.queue.currentEntry else { return }
                switch entry.item {
                case let .song(song):
                    if let currentSong = self?.currentList.first(where: { $0.id == song.id }) {
                        self?.fetchNext.send(currentSong)
                        let config = MusicConfig(item: currentSong, play: true)
                        self?.musicItem = config
                    }
                default:
                    return
                }
        }
        .store(in: &store)
    }
    
    func putSingleSong(_ song: Song) {
        mediaPlayer.queue = [song]
    }
    
    func putMultipleSongs(_ songs: [Song]) {
        mediaPlayer.queue = .init(for: songs)
    }
    
    func insertToTail(_ songs: [Song]) async throws {
        currentList.append(contentsOf: songs)
        try await mediaPlayer.queue.insert(songs, position: .tail)
    }
    
    func playNext() async throws {
        if mediaPlayer.queue.entries.count <= 1 {
            return
        }
        do {
            try await mediaPlayer.skipToNextEntry()
        } catch {
            print(error)
        }
    }
}


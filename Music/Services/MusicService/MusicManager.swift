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

class MusicManager: ObservableObject {
    
    @Published var musicItem: MyMusicItem?
    @Published var songTitle: String = ""
    @Published var musicDuration: TimeInterval = 0.0
    @Published var songIconUrl: URL?
    @Published var status: MusicPlayer.PlaybackStatus = .stopped
    @Published var playbackTime: TimeInterval = 0.0
    private var timer: Timer?
    
    static func getAuthorizationStatus() async -> MusicAuthorization.Status {
        return await MusicAuthorization.request()
    }
    
    private var store = Set<AnyCancellable>()
    private var mediaPlayer: ApplicationMusicPlayer {
        ApplicationMusicPlayer.shared
    }
    
    func setupMusicItem(_ musicItem: MyMusicItem) async -> Bool {
        if let song = self.musicItem as? Song {
            let newSong = musicItem as? Song
            if song == newSong {
                return false
            }
        }
        self.musicItem = musicItem
        return true
    }
    
    func startObserving() {
        $musicItem.sink { [weak self] item in
            guard let self = self else { return }
            guard let item = item else { return }
            let currentSong = self.musicItem as? Song
            if let song = item as? Song {
                if song == currentSong {
                    return
                }
                self.playbackTime = 0
                self.songTitle = song.title
                self.songIconUrl = song.artwork?.url(width: 50, height: 50)
                self.musicDuration = song.duration ?? 0
                self.mediaPlayer.playbackTime = 0
            }
            
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                self.playbackTime = self.mediaPlayer.playbackTime
            }
        }
        .store(in: &store)
        
        mediaPlayer.state.objectWillChange.sink { [weak self] _ in
            guard let self = self else { return }
            self.status = self.mediaPlayer.state.playbackStatus
        }
        .store(in: &store)
    }
    
    func play() {
        guard let song = musicItem as? Song else { return }
        Task {
            try await self.play(song: song)
        }
    }
    
    func get() {
//            let albumCharts = respone.albumCharts
//            let playlistCharts = respone.playlistCharts
//            let musicVideoCharts = respone.musicVideoCharts
//            let songCharts = respone.songCharts
        
        
        
//            let album = albumCharts.first?.items.first
//            print(album?.artwork?.url(width: 300, height: 300))
//            print(album)
//
//            let playlist = playlistCharts.first?.items.first
//            print(playlist?.artwork?.url(width: 300, height: 300))
//            print(playlistCharts)

//            let musicVideoChart = musicVideoCharts.first?.items.first
//            print(musicVideoChart?.artwork?.url(width: 300, height: 300))
        
        
//            let res = try await musicVideoChart?.with([.songs])
//            print(dump(res?.songs?.first))
//
//            try await play(song:(res?.songs?.first)!)
        
//            print(respone)
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
    
    func getRecentlyPlayed() {
        Task {
            //            let request = MusicRecentlyPlayedContainerRequest()
            //            let response = try await request.response()
            
            let request = MusicRecentlyPlayedRequest<Song>()
            let response = try await request.response()
            
            print(response.items)
            
            try await play(song: response.items.last!)
        }
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
    
    func play(song: Song) async throws {
        mediaPlayer.queue = [song]
        try await mediaPlayer.prepareToPlay()
        try await mediaPlayer.play()
        
        //        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
        //            guard self != nil else {
        //                timer.invalidate()
        //                return
        //            }
        //            let time = self.mediaPlayer.playbackTime
        //            self?.currentTimePublisher.send(time)
        //            if mediaPlayer.queue.entries == .init() {
        //                timer.invalidate()
        //            }
        //        }
        //        let runLoop = RunLoop.current
        //        runLoop.add(timer, forMode: .default)
        //        runLoop.run()
        
        //            let request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: "1603171516")
        //             let response = try await request.response()
        //            print(response)
    }
    
    func pause() {
        mediaPlayer.pause()
    }
    
    private func prepareToPlay() async throws {
        if mediaPlayer.queue.entries.count == 0 {
            guard let song = musicItem as? Song else { return }
            mediaPlayer.queue = [song]
        }
        try await mediaPlayer.prepareToPlay()
    }
    
    func resume() async {
        Task {
            try await prepareToPlay()
            try await mediaPlayer.play()
        }
    }
    
    func skipTo(_ time: TimeInterval) {
        mediaPlayer.playbackTime = time
    }
    
    func stopPlaying() {
        mediaPlayer.queue.entries = .init()
        mediaPlayer.stop()
    }
}


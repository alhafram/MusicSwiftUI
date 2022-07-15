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
    
    let currentTimePublisher = CurrentValueSubject<TimeInterval, Never>(0)
    
    private var mediaPlayer: ApplicationMusicPlayer {
        ApplicationMusicPlayer.shared
    }
    
    var playbackTime: TimeInterval {
        mediaPlayer.playbackTime
    }
    
    func authorize() async -> MusicAuthorization.Status {
        return await MusicAuthorization.request()
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
    
    func resume() async {
        Task {
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


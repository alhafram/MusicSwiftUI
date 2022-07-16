//
//  MusicAPIManager.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

protocol MusicAPI {
    func getCharts() async throws -> ([AlbumChartViewModel], [PlaylistChartViewModel], [MusicVideoChartViewModel])
}

struct MusicAPIManager: MusicAPI {
    
    func getCharts() async throws -> ([AlbumChartViewModel], [PlaylistChartViewModel], [MusicVideoChartViewModel]) {
        let task = Task {
            let request = MusicCatalogChartsRequest(kinds: [.cityTop, .dailyGlobalTop, .mostPlayed], types: [Album.self, Playlist.self, MusicVideo.self, Song.self])
            let respone = try await request.response()
            let albumChartViewModels = respone.albumCharts.map { AlbumChartViewModel(albumChart: $0) }
            let playlistChartViewModels = respone.playlistCharts.map { PlaylistChartViewModel(playlistChart: $0) }
            let musicViewoChartViewModels = respone.musicVideoCharts.map { MusicVideoChartViewModel(musicVideoChart: $0) }
            
            return (albumChartViewModels, playlistChartViewModels, musicViewoChartViewModels)
        }
        return try await task.result.get()
    }
}

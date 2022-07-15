//
//  MusicAPIManager.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

protocol MusicAPI {
    func getCharts() async throws -> AlbumChartViewModel
}

struct MusicAPIManager: MusicAPI {
    
    func getCharts() async throws -> AlbumChartViewModel {
        let task = Task {
            let request = MusicCatalogChartsRequest(kinds: [.cityTop, .dailyGlobalTop, .mostPlayed], types: [Album.self, Playlist.self, MusicVideo.self, Song.self])
            let respone = try await request.response()
            
            let albumChart = respone.albumCharts[0]
            
            let albumChartViewModel = AlbumChartViewModel(albumChart: albumChart)
            return albumChartViewModel
        }
        return try await task.result.get()
    }
}

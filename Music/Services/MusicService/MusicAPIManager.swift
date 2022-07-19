//
//  MusicAPIManager.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

protocol MusicAPI {
    func getCharts() async throws -> Charts
}

struct MusicAPIManager: MusicAPI {
    
    func getCharts() async throws -> Charts {
        let task = Task {
            let request = MusicCatalogChartsRequest(kinds: [.cityTop, .dailyGlobalTop, .mostPlayed],
                                                    types: [Album.self, Playlist.self, MusicVideo.self, Song.self])
            let respone = try await request.response()
            return Charts(albumCharts: respone.albumCharts,
                          playlistCharts: respone.playlistCharts,
                          musicVideoCharts: respone.musicVideoCharts,
                          songsCharts: respone.songCharts)
        }
        return try await task.result.get()
    }
    
    func fetchNext<T: MusicCatalogChartRequestable>(batcher: inout MusicItemCollection<T>, next: Int = 10) async throws {
        if batcher.hasNextBatch {
            guard let batchResponse = try await batcher.nextBatch(limit: next) else {
                throw MusicAPIError.fetchError
            }
            batcher = batchResponse
        }
    }
}

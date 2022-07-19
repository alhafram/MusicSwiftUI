//
//  AlbumChartViewModel.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

struct ChartViewModelItem: Hashable, Identifiable {
    var id = UUID()
    var artistName = ""
    var title: String
    var artwork: Artwork?
}

class ChartViewModel<T>: ObservableObject, Identifiable where T: MusicCatalogChartRequestable {
    
    @Published var items: [ChartViewModelItem]
    
    let title: String
    var batcher: MusicItemCollection<T>
    
    var type: T.Type {
        return T.self
    }
    
    init(chart: MusicCatalogChart<T>) {
        self.title = chart.title
        self.items = []
        self.batcher = chart.items
        self.items = parse(chart.items)
    }
    
    func parse(_ collection:  MusicItemCollection<T>) -> [ChartViewModelItem] {
        let chartViewModelItems = collection.compactMap {
            if let album = $0 as? Album {
                return ChartViewModelItem(artistName: album.artistName, title: album.title, artwork: album.artwork)
            }
            if let playlist = $0 as? Playlist {
                return ChartViewModelItem(title: playlist.name, artwork: playlist.artwork)
            }
            if let musicVideo = $0 as? MusicVideo {
                return ChartViewModelItem(artistName: musicVideo.artistName, title: musicVideo.title, artwork: musicVideo.artwork)
            }
            if let song = $0 as? Song {
                return ChartViewModelItem(artistName: song.artistName, title: song.title, artwork: song.artwork)
            }
            return nil
        }
        return chartViewModelItems
    }
    
    func addItems(_ items: [ChartViewModelItem]) {
        self.items.append(contentsOf: items)
    }
    
    func prefetchingLimit(from viewModel: ChartViewModelItem) -> Int {
        return items.count - 10
    }
}

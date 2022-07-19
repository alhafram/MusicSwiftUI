//
//  AlbumChartViewModel.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

protocol MyMusicItem {
    
}
extension Song: MyMusicItem {}
extension Playlist: MyMusicItem {}
extension Album: MyMusicItem {}
extension MusicVideo: MyMusicItem {}

struct ChartViewModelItem: Hashable, Identifiable, Equatable {
    var id = UUID()
    var artistName = ""
    var title: String
    var artwork: Artwork?
    var item: MyMusicItem
    
    static func == (lhs: ChartViewModelItem, rhs: ChartViewModelItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
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
        self.items = parseItems()
    }
    
    func parseItems() -> [ChartViewModelItem] {
        let chartViewModelItems = batcher.compactMap {
            if let album = $0 as? Album {
                return ChartViewModelItem(artistName: album.artistName, title: album.title, artwork: album.artwork, item: album)
            }
            if let playlist = $0 as? Playlist {
                return ChartViewModelItem(title: playlist.name, artwork: playlist.artwork, item: playlist)
            }
            if let musicVideo = $0 as? MusicVideo {
                return ChartViewModelItem(artistName: musicVideo.artistName, title: musicVideo.title, artwork: musicVideo.artwork, item: musicVideo)
            }
            if let song = $0 as? Song {
                return ChartViewModelItem(artistName: song.artistName, title: song.title, artwork: song.artwork, item: song)
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

//
//  AlbumChartViewModel.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

struct AlbumChartViewModel {
    
    struct Item: Hashable, Identifiable {
        var id = UUID()
        var artistName: String
        var title: String
        var artwork: Artwork?
    }
    
    let title: String
    var items: [Item]
    var albumChart: MusicCatalogChart<Album>
    
    init(albumChart: MusicCatalogChart<Album>) {
        self.title = albumChart.title
        self.items = albumChart.items.map {
            Item(artistName: $0.artistName, title: $0.title, artwork: $0.artwork)
        }
        self.albumChart = albumChart
    }
}

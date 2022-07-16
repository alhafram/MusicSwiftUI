//
//  AlbumChartViewModel.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

class AlbumChartViewModel: ObservableObject, Identifiable {
    
    @Published var items: [Item]
    
    let title: String
    var batcher: MusicItemCollection<Album>
    
    init(albumChart: MusicCatalogChart<Album>) {
        self.title = albumChart.title
        self.items = albumChart.items.map {
            Item(artistName: $0.artistName, title: $0.title, artwork: $0.artwork)
        }
        self.batcher = albumChart.items
    }
    
    func updateBatcher(_ batcher: MusicItemCollection<Album>) {
        self.batcher = batcher
    }
    
    func addItems(_ items: [Item]) {
        self.items.append(contentsOf: items)
    }
}

extension AlbumChartViewModel {
    struct Item: Hashable, Identifiable {
        var id = UUID()
        var artistName: String
        var title: String
        var artwork: Artwork?
    }
}

class PlaylistChartViewModel: ObservableObject, Identifiable {
    
    @Published var items: [Item]
    
    let title: String
    var batcher: MusicItemCollection<Playlist>
    
    init(playlistChart: MusicCatalogChart<Playlist>) {
        self.title = playlistChart.title
        self.items = playlistChart.items.map {
            Item(title: $0.name, artwork: $0.artwork)
        }
        self.batcher = playlistChart.items
    }
    
    func updateBatcher(_ batcher: MusicItemCollection<Playlist>) {
        self.batcher = batcher
    }
    
    func addItems(_ items: [Item]) {
        self.items.append(contentsOf: items)
    }
}

extension PlaylistChartViewModel {
    struct Item: Hashable, Identifiable {
        var id = UUID()
        var title: String
        var artwork: Artwork?
    }
}


class MusicVideoChartViewModel: ObservableObject, Identifiable {
    
    @Published var items: [Item]
    
    let title: String
    var batcher: MusicItemCollection<MusicVideo>
    
    init(musicVideoChart: MusicCatalogChart<MusicVideo>) {
        self.title = musicVideoChart.title
        self.items = musicVideoChart.items.map {
            Item(artistName: $0.artistName, title: $0.title, artwork: $0.artwork)
        }
        self.batcher = musicVideoChart.items
    }
    
    func updateBatcher(_ batcher: MusicItemCollection<MusicVideo>) {
        self.batcher = batcher
    }
    
    func addItems(_ items: [Item]) {
        self.items.append(contentsOf: items)
    }
}

extension MusicVideoChartViewModel {
    struct Item: Hashable, Identifiable {
        var id = UUID()
        var artistName: String
        var title: String
        var artwork: Artwork?
    }
}

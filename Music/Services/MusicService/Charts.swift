//
//  Charts.swift
//  Music
//
//  Created by Albert on 19.07.2022.
//

import Foundation
import MusicKit

struct Charts {
    var albumCharts: [MusicCatalogChart<Album>]
    var playlistCharts: [MusicCatalogChart<Playlist>]
    var musicVideoCharts: [MusicCatalogChart<MusicVideo>]
    var songsCharts: [MusicCatalogChart<Song>]
}

//
//  ChartsProvider.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import Foundation
import MusicKit

class ChartsProvider: ObservableObject {
    
    enum State {
        case loading
        case data
        case error
    }
    
    @Published var state = State.loading
    @Published var albumChartViewModels = [ChartViewModel<Album>]()
    @Published var playlistChartViewModels = [ChartViewModel<Playlist>]()
    @Published var musicVideoChartViewModels = [ChartViewModel<MusicVideo>]()
    @Published var songChartViewModels = [ChartViewModel<Song>]()
    
    private let musicManager = MusicAPIManager()
    private var fetching = false
    
    func loadCharts() async {
        do {
            let charts = try await musicManager.getCharts()
            albumChartViewModels = charts.albumCharts.map { ChartViewModel(chart: $0) }
            playlistChartViewModels = charts.playlistCharts.map { ChartViewModel(chart: $0) }
            musicVideoChartViewModels = charts.musicVideoCharts.map { ChartViewModel(chart: $0) }
            songChartViewModels = charts.songsCharts.map { ChartViewModel(chart: $0) }
            state = .data
        } catch {
            print("Error", error.localizedDescription)
            state = .error
        }
    }
    
    func fetchNext<T: MusicCatalogChartRequestable>(currentItem: ChartViewModelItem, in viewModel: ChartViewModel<T>) async {
        guard let index = viewModel.items.firstIndex(of: currentItem) else { return }
        if index >= viewModel.prefetchingLimit(from: currentItem) && !fetching {
            fetching = true
            do {
                try await musicManager.fetchNext(batcher: &viewModel.batcher)
                let newItems = viewModel.parseItems()
                viewModel.addItems(newItems)
            } catch {
                print(error)
            }
            fetching = false
        }
    }
}

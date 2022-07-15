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
    @Published var title = ""
    @Published var items = [AlbumChartViewModel.Item]()
    
    private var batcher: MusicItemCollection<Album>?
    
    private var prefetchingLimit: Int {
        items.count - 10
    }
    
    private var fetching = false
    
    func loadCharts() async {
        do {
            let viewModel = try await MusicAPIManager().getCharts()
            title = viewModel.title
            items = viewModel.items
            batcher = viewModel.albumChart.items
            state = .data
        } catch {
            state = .error
        }
    }
    
    func fetchNext(currentItem: AlbumChartViewModel.Item) async {
        guard let index = items.firstIndex(of: currentItem) else { return }
        if index >= prefetchingLimit && !fetching {
            fetching = true
            do {
                if batcher?.hasNextBatch ?? false {
                    let res = try await batcher?.nextBatch(limit: 20)
                    guard let res = res else { return }
                    batcher = res
                    let newBatch = res.map { AlbumChartViewModel.Item(artistName: $0.artistName, title: $0.title, artwork: $0.artwork) }
                    items.append(contentsOf: newBatch)
                    print(items.count)
                }
            } catch {
                print(error)
            }
            fetching = false
        }
    }
}

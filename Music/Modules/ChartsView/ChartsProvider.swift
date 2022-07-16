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
    @Published var viewModels = [AlbumChartViewModel.Item]()
    @Published var albumChartViewModels = [AlbumChartViewModel]()
    @Published var playlistChartViewModels = [PlaylistChartViewModel]()
    @Published var musicVideoChartViewModels = [MusicVideoChartViewModel]()
    
    private func prefetchingLimit(from viewModel: AlbumChartViewModel) -> Int {
        return viewModel.items.count - 10
    }
    
    private func prefetchingLimit2(from viewModel: PlaylistChartViewModel) -> Int {
        return viewModel.items.count - 10
    }
    
    private func prefetchingLimit3(from viewModel: MusicVideoChartViewModel) -> Int {
        return viewModel.items.count - 10
    }
    
    private var fetching = false
    
    func loadCharts() async {
        do {
            (albumChartViewModels, playlistChartViewModels, musicVideoChartViewModels) = try await MusicAPIManager().getCharts()
            state = .data
        } catch {
            state = .error
        }
    }
    
    func fetchNext(currentItem: AlbumChartViewModel.Item, in viewModel: AlbumChartViewModel) async {
        guard let index = viewModel.items.firstIndex(of: currentItem) else { return }
        if index >= prefetchingLimit(from: viewModel) && !fetching {
            fetching = true
            do {
                if viewModel.batcher.hasNextBatch {
                    let res = try await viewModel.batcher.nextBatch(limit: 20)
                    guard let res = res else { return }
                    viewModel.updateBatcher(res)
                    let newBatch = res.map { AlbumChartViewModel.Item(artistName: $0.artistName, title: $0.title, artwork: $0.artwork) }
                    viewModel.addItems(newBatch)
                }
            } catch {
                print(error)
            }
            fetching = false
        }
    }
    
    func fetchNext(currentItem: PlaylistChartViewModel.Item, in viewModel: PlaylistChartViewModel) async {
        guard let index = viewModel.items.firstIndex(of: currentItem) else { return }
        if index >= prefetchingLimit2(from: viewModel) && !fetching {
            fetching = true
            do {
                if viewModel.batcher.hasNextBatch {
                    let res = try await viewModel.batcher.nextBatch(limit: 20)
                    guard let res = res else { return }
                    viewModel.updateBatcher(res)
                    let newBatch = res.map { PlaylistChartViewModel.Item(title: $0.name, artwork: $0.artwork) }
                    viewModel.addItems(newBatch)
                }
            } catch {
                print(error)
            }
            fetching = false
        }
    }
    
    func fetchNext(currentItem: MusicVideoChartViewModel.Item, in viewModel: MusicVideoChartViewModel) async {
        guard let index = viewModel.items.firstIndex(of: currentItem) else { return }
        if index >= prefetchingLimit3(from: viewModel) && !fetching {
            fetching = true
            do {
                if viewModel.batcher.hasNextBatch {
                    let res = try await viewModel.batcher.nextBatch(limit: 20)
                    guard let res = res else { return }
                    viewModel.updateBatcher(res)
                    let newBatch = res.map { MusicVideoChartViewModel.Item(artistName: $0.artistName, title: $0.title, artwork: $0.artwork) }
                    viewModel.addItems(newBatch)
                }
            } catch {
                print(error)
            }
            fetching = false
        }
    }
}

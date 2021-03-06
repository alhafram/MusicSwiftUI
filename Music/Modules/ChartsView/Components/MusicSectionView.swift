//
//  MusicSectionView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI
import MusicKit

struct MusicSectionView<T: MusicCatalogChartRequestable>: View {
    
    @EnvironmentObject private var chartsProvider: ChartsProvider
    @EnvironmentObject private var musicManager: MusicManager
    
    @ObservedObject var viewModel: ChartViewModel<T>
    var showPlayAll = false
    
    @ViewBuilder
    private var title: some View {
        HStack {
            Text(viewModel.title)
                .font(.title2)
                .bold()
            if showPlayAll  {
                Spacer()
                Button {
                    do {
                        try musicManager.playSongs(viewModel.songs)
                    } catch {
                        print(error)
                    }
                } label: {
                    Text("Play all")
                        .bold()
                }
                .padding(.trailing, 16)
                .foregroundColor(.accentColor)
            }
        }
    }
    
    private func nextFetch(item: ChartViewModelItem) async {
        await chartsProvider.fetchNext(currentItem: item, in: viewModel)
    }
    
    @ViewBuilder
    private func buildItem(item: ChartViewModelItem) -> some View {
        if viewModel.type is Album.Type {
            AlbumView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .onTapGesture {
                    print(item.item)
                }
        }
        if viewModel.type is Playlist.Type {
            PlaylistView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .onTapGesture {
                    print(item.item)
                }
        }
        if viewModel.type is MusicVideo.Type {
            MusicVideoView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .onTapGesture {
                    print(item.item)
                }
        }
        if viewModel.type is Song.Type {
            SongView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .onTapGesture {
                    musicManager.musicItem = MusicConfig(item: item.item, play: true)
                    musicManager.putSingleSong(item.item as! Song)
                }
        }
    }
    
    @ViewBuilder
    private func buildSection() -> some View {
        title
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.items, id: \.self) { item in
                    buildItem(item: item)
                }
            }
        }
        .padding(.top, -30)
    }
    
    var body: some View {
        buildSection()
            .padding()
            .scrollIndicators(.never)
    }
}

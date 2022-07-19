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
    @EnvironmentObject private var router: Router
    
    @ObservedObject var viewModel: ChartViewModel<T>
    
    var title: some View {
        Text(viewModel.title)
            .font(.title2)
            .bold()
    }
    
    private func nextFetch(item: ChartViewModelItem) async {
        await chartsProvider.fetchNext(currentItem: item, in: viewModel)
    }
    
    @ViewBuilder
    func buildItem(item: ChartViewModelItem) -> some View {
        if viewModel.type is Album.Type {
            AlbumView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .environmentObject(router)
        }
        if viewModel.type is Playlist.Type {
            PlaylistView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .environmentObject(router)
        }
        if viewModel.type is MusicVideo.Type {
            MusicVideoView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .environmentObject(router)
        }
        if viewModel.type is Song.Type {
            PlaylistView(item: item)
                .task {
                    await nextFetch(item: item)
                }
                .environmentObject(router)
        }
    }
    
    @ViewBuilder
    func buildSection() -> some View {
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

//struct AlbumSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumSectionView(viewModel: )
//    }
//}

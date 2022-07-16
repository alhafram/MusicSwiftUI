//
//  ChartsView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct ChartsView: View {
    
    @EnvironmentObject private var router: Router
    
    @ObservedObject var chartsProvider = ChartsProvider()
    
    @ViewBuilder
    func getContentView() -> some View {
        switch chartsProvider.state {
        case .loading:
            ProgressView()
        case .data:
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(chartsProvider.albumChartViewModels) { albumChartViewModel in
                            AlbumSectionView(viewModel: albumChartViewModel)
                                .environmentObject(chartsProvider)
                        }
                        ForEach(chartsProvider.playlistChartViewModels) { playlistChartViewModel in
                            PlaylistSectionView(viewModel: playlistChartViewModel)
                                .environmentObject(chartsProvider)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .navigationTitle("Listen now")
            }
        case .error:
            Text("ERROR")
        }
    }
    
    var body: some View {
        getContentView()
            .task {
                await chartsProvider.loadCharts()
            }
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}

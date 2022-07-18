//
//  ChartsView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct ChartsView: View {
    
    @EnvironmentObject private var router: Router
    @StateObject var chartsProvider = ChartsProvider()
    
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
                                .environmentObject(router)
                        }
                        ForEach(chartsProvider.playlistChartViewModels) { playlistChartViewModel in
                            PlaylistSectionView(viewModel: playlistChartViewModel)
                                .environmentObject(chartsProvider)
                                .environmentObject(router)
                        }
                        
                        ForEach(chartsProvider.musicVideoChartViewModels) { musicVideoChartViewModel in
                            MusicVideoSectionView(viewModel: musicVideoChartViewModel)
                                .environmentObject(chartsProvider)
                                .environmentObject(router)
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
                if chartsProvider.state == .loading {
                    await chartsProvider.loadCharts()
                    chartsProvider.state = .data
                }
            }
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}

//
//  ChartsView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct ChartsView: View {
    
    @EnvironmentObject private var musicManager: MusicManager
    
    @StateObject private var chartsProvider = ChartsProvider()
    
    @ViewBuilder
    func getContentView() -> some View {
        switch chartsProvider.state {
        case .loading:
            ProgressView()
        case .data:
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(chartsProvider.albumChartViewModels) { viewModel in
                            MusicSectionView(viewModel: viewModel)
                                .environmentObject(chartsProvider)
                        }
                        ForEach(chartsProvider.playlistChartViewModels) { viewModel in
                            MusicSectionView(viewModel: viewModel)
                                .environmentObject(chartsProvider)
                        }
                        ForEach(chartsProvider.musicVideoChartViewModels) { viewModel in
                            MusicSectionView(viewModel: viewModel)
                                .environmentObject(chartsProvider)
                        }
                        ForEach(chartsProvider.songChartViewModels) { viewModel in
                            MusicSectionView(viewModel: viewModel)
                                .environmentObject(chartsProvider)
                        }
                        if musicManager.musicItem != nil {
                            Text("")
                                .frame(height: 100)
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
            .environmentObject(Router())
            .environmentObject(MusicManager())
    }
}

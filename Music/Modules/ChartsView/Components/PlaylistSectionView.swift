//
//  PlaylistSectionView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI

struct PlaylistSectionView: View {
    
    @EnvironmentObject private var chartsProvider: ChartsProvider
    @StateObject var viewModel: PlaylistChartViewModel
    
    var title: some View {
        Text(viewModel.title)
            .foregroundColor(Color.backgroundColor)
            .font(.title2)
            .bold()
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
    }
    
    var body: some View {
        title
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.items) { item in
                    PlaylistView(item: item)
                        .task {
                            await chartsProvider.fetchNext(currentItem: item, in: viewModel)
                        }
                }
            }
        }
        .padding()
        .scrollIndicators(.never)
    }
}

//struct PlaylistSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistSectionView(viewModel: )
//    }
//}

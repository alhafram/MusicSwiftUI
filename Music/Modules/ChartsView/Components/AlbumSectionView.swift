//
//  AlbumSectionView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI

struct AlbumSectionView: View {
    
    @EnvironmentObject private var chartsProvider: ChartsProvider
    
    var title: some View {
        Text(chartsProvider.title)
            .foregroundColor(Color.backgroundColor)
            .font(.title2)
            .bold()
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
    }
    
    var body: some View {
        title
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(chartsProvider.items) { item in
                    AlbumView(item: item)
                        .task {
                            await chartsProvider.fetchNext(currentItem: item)
                        }
                }
            }
        }
        .padding()
        .scrollIndicators(.never)
    }
}

struct AlbumSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSectionView()
    }
}

//
//  RecentlyPlayedSection.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct RecentlyPlayedSection: View {
    
    var recentlyPlayed: [TopPicksViewModel.MusicItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Recently Played")
                    .bold()
                    .font(.title2)
                Spacer()
                Button("See All") {
                    
                }
                .foregroundColor(.red)
                .buttonStyle(BorderlessButtonStyle())
            }
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(recentlyPlayed, id: \.self) { musicItem in
                        VStack {
                            MusicItemView(viewModel: musicItem)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
}

struct RecentlyPlayedSection_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyPlayedSection(recentlyPlayed: [])
    }
}


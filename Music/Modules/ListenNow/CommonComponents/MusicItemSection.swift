//
//  MusicItemSection.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

enum MusicItemSectionType {
    case recently
    case standart
}

struct MusicItemSection: View {
    var type: MusicItemSectionType
    var title: String
    var recentlyPlayed: [TopPicksViewModel.MusicItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            buildHeader()
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
    
    func buildHeader() -> some View {
        HStack {
            Text(title)
                .bold()
                .font(.title2)
            switch type {
            case .recently:
                Spacer()
                Button("See All") {
                    
                }
                .foregroundColor(.red)
                .buttonStyle(BorderlessButtonStyle())
            case .standart:
                EmptyView()
            }
        }
    }
}

struct MusicItemSection_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemSection(type: .standart, title: "", recentlyPlayed: [])
    }
}


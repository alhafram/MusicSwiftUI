//
//  DigestMusicSection.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestMusicSection: View {
    var title: String
    var items: [MusicModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.title2)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(items, id: \.self) { item in
                        DigestPlainView(viewModel: item)
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
}

struct DigestMusicSection_Previews: PreviewProvider {
    static var previews: some View {
        DigestMusicSection(title: "", items: [])
    }
}

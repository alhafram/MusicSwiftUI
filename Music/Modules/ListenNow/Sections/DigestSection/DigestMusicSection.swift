//
//  DigestMusicSection.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestMusicSection: View {
    var title: String
    var topPicks: [TopPicksViewModel.TopPick]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.title2)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(topPicks, id: \.self) { topPick in
                        switch topPick.modelType {
                        case .headerLogoView:
                            DigestHeaderLogoView(viewModel: topPick)
                        case .plainView:
                            DigestPlainView(viewModel: topPick)
                        case .topTrailingLogoView:
                            DigestMusicSectionTopTrailingLogoView(viewModel: topPick)
                        case .centerTextView:
                            DigestCenterTextView(viewModel: topPick)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
}

struct DigestMusicSection_Previews: PreviewProvider {
    static var previews: some View {
        DigestMusicSection(title: "", topPicks: [])
    }
}

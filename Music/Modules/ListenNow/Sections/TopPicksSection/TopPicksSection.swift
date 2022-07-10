//
//  TopPicksSection.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksSection: View {
    var topPicks: [TopPicksViewModel.TopPick]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Picks")
                .bold()
                .font(.title2)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(topPicks, id: \.self) { topPick in
                        switch topPick.modelType {
                        case .headerLogoView:
                            TopPicksHeaderLogoView(viewModel: topPick)
                        case .plainView:
                            TopPicksPlainView(viewModel: topPick)
                        case .topTrailingLogoView:
                            TopPicksTopTrailingLogoView(viewModel: topPick)
                        case .centerTextView:
                            TopPicksCenterTextView(viewModel: topPick)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
}

struct TopPicksSection_Previews: PreviewProvider {
    static var previews: some View {
        TopPicksSection(topPicks: [])
    }
}

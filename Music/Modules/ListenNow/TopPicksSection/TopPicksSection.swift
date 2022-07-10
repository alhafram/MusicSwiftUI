//
//  TopPicksSection.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksSection: View {
    private let viewModel = TopPicksViewModel(topPicks: [
        TopPicksViewModel.TopPick(modelType: .plainView,
                                  title: "Albert's Station",
                                  subtitle: "Made for You",
                                  imageUrl: "http://192.168.1.7:8887/madeForYou.png"),
        TopPicksViewModel.TopPick(modelType: .headerLogoView,
                                  title: "Maribou State, OTR, Cathing Flies, RKCB, Hazey Eyes, Isabel, Utah, TRACE, Moglii, Filous, Harrison Brome",
                                  subtitle: "Made for You",
                                  imageUrl: "http://192.168.1.7:8887/madeForYou2.png",
                                  contentString: "chill \nmix".uppercased()),
        TopPicksViewModel.TopPick(modelType: .centerTextView,
                                  title: "Frient - Single\nLucky Luke & Gaulling\n2018",
                                  subtitle: "Made from Lucky Luke",
                                  imageUrl: "http://192.168.1.7:8887/moreFromLuckyLuke.png",
                                 contentString: "lucky luke & gaulling friend".uppercased()),
        TopPicksViewModel.TopPick(modelType: .topTrailingLogoView,
                                  title: "Lvly & Similar Artists",
                                  subtitle: "Featuring Vlvly",
                                  imageUrl: "http://192.168.1.7:8887/featuringLvly.png")
    ])
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Picks")
                .bold()
                .font(.title2)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(viewModel.topPicks, id: \.self) { topPick in
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
        TopPicksSection()
    }
}

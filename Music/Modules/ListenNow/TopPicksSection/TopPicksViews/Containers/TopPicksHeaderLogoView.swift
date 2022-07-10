//
//  TopPicksHeaderLogoView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksHeaderLogoView: View {
    var viewModel: TopPicksViewModel.TopPick
    
    var body: some View {
        VStack(alignment: .leading) {
            TopPickSubtitleView(subtitle: viewModel.subtitle)
            VStack {
                HStack {
                    TopPicksAppleLogoView()
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                HStack {
                    Text(viewModel.contentString ?? "")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                Spacer()
                TopPickTitleView(title: viewModel.title)
            }
            .frame(width: 250, height: 300)
            .background {
                TopPicksBackgroundImageView(imageUrlString: viewModel.imageUrl)
            }
        }
    }
}


struct TopPicksHeaderLogoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.TopPick(modelType: .headerLogoView,
                                                  title: "Maribou State, OTR, Cathing Flies, RKCB, Hazey Eyes, Isabel, Utah, TRACE, Moglii, Filous, Harrison Brome",
                                                  subtitle: "Made for You",
                                                  imageUrl: "http://192.168.1.7:8887/madeForYou2.png",
                                                  contentString: "chill \nmix".uppercased())
        TopPicksHeaderLogoView(viewModel: viewModel)
    }
}

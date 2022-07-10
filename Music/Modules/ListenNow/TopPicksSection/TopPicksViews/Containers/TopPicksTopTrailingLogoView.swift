//
//  TopPicksTopTrailingLogoView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksTopTrailingLogoView: View {
    var viewModel: TopPicksViewModel.TopPick
    
    var body: some View {
        VStack(alignment: .leading) {
            TopPickSubtitleView(subtitle: viewModel.subtitle)
            VStack {
                HStack {
                    Spacer()
                    TopPicksAppleLogoView()
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 20))
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


struct TopPicksTopTrailingLogoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel =
        TopPicksViewModel.TopPick(modelType: .topTrailingLogoView,
                                  title: "Lvly & Similar Artists",
                                  subtitle: "Featuring Vlvly",
                                  imageUrl: "http://192.168.1.7:8887/featuringLvly.png")
        TopPicksTopTrailingLogoView(viewModel: viewModel)
    }
}

//
//  PlainView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksPlainView: View {
    var viewModel: TopPicksViewModel.TopPick
    
    var body: some View {
        VStack(alignment: .leading) {
            TopPickSubtitleView(subtitle: viewModel.subtitle)
            VStack {
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

struct TopPicksPlainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.TopPick(modelType: .plainView,
                                                  title: "Albert's Station",
                                                  subtitle: "Made for You",
                                                  imageUrl: "http://192.168.1.7:8887/madeForYou.png")
        TopPicksPlainView(viewModel: viewModel)
    }
}

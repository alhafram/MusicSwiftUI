//
//  TopPicksCenterTextView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksCenterTextView: View {
    var viewModel: TopPicksViewModel.TopPick
    
    var body: some View {
        VStack(alignment: .leading) {
            TopPickSubtitleView(subtitle: viewModel.subtitle)
            VStack {
                VStack {
                    Spacer()
                    Spacer()
                    Text(viewModel.contentString ?? "")
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Spacer()
                }
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

struct TopPicksCenterTextView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.TopPick(modelType: .centerTextView,
                                                  title: "Frient - Single\nLucky Luke & Gaulling\n2018",
                                                  subtitle: "Made from Lucky Luke",
                                                  imageUrl: "http://192.168.1.7:8887/moreFromLuckyLuke.png",
                                                  contentString: "lucky luke & gaulling friend".uppercased())
        TopPicksCenterTextView(viewModel: viewModel)
    }
}

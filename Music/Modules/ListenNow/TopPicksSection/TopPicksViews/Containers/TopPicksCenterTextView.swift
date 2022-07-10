//
//  TopPicksCenterTextView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksCenterTextView: View {
    var viewModel: TopPicksViewModel.TopPick
    @State private var isLongPressing = false
    
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
            .frame(width: 300, height: 400)
            .background {
                TopPicksBackgroundImageView(imageUrlString: viewModel.imageUrl)
            }
        }
        .scaleEffect(isLongPressing ? 0.95 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
            withAnimation {
                isLongPressing = isPressing
            }
        }) {}
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

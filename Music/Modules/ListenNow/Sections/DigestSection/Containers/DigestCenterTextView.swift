//
//  DigestCenterTextView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestCenterTextView: View {
    var viewModel: TopPicksViewModel.TopPick
    @State private var isLongPressing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DigestSubtitleView(subtitle: viewModel.subtitle)
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
                DigestTitleView(title: viewModel.title)
            }
            .frame(width: 300, height: 400)
            .background {
                BackgroundImageView(imageUrlString: viewModel.imageUrl, cornerRadius: 12, size: .init(width: 300, height: 400))
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

struct DigestCenterTextView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.TopPick(modelType: .centerTextView,
                                                  title: "Frient - Single\nLucky Luke & Gaulling\n2018",
                                                  subtitle: "Made from Lucky Luke",
                                                  imageUrl: "http://192.168.1.7:8887/moreFromLuckyLuke.png",
                                                  contentString: "lucky luke & gaulling friend".uppercased())
        DigestCenterTextView(viewModel: viewModel)
    }
}

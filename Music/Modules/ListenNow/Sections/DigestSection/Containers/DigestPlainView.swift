//
//  DigestPlainView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestPlainView: View {
    var viewModel: TopPicksViewModel.TopPick
    @State private var isLongPressing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DigestSubtitleView(subtitle: viewModel.subtitle)
            VStack {
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

struct DigestPlainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.TopPick(modelType: .plainView,
                                                  title: "Albert's Station",
                                                  subtitle: "Made for You",
                                                  imageUrl: "http://192.168.1.7:8887/madeForYou.png")
        DigestPlainView(viewModel: viewModel)
    }
}

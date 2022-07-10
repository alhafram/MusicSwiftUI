//
//  DigestMusicSectionTopTrailingLogoView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestMusicSectionTopTrailingLogoView: View {
    var viewModel: TopPicksViewModel.TopPick
    @State private var isLongPressing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DigestSubtitleView(subtitle: viewModel.subtitle)
            VStack {
                HStack {
                    Spacer()
                    AppleLogoView()
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 20))
                Spacer()
                DigestTitleView(title: viewModel.title)
            }
            .frame(width: 300, height: 400)
            .background {
                DigestBackgroundImageView(imageUrlString: viewModel.imageUrl)
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


struct DigestMusicSectionTopTrailingLogoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel =
        TopPicksViewModel.TopPick(modelType: .topTrailingLogoView,
                                  title: "Lvly & Similar Artists",
                                  subtitle: "Featuring Vlvly",
                                  imageUrl: "http://192.168.1.7:8887/featuringLvly.png")
        DigestMusicSectionTopTrailingLogoView(viewModel: viewModel)
    }
}

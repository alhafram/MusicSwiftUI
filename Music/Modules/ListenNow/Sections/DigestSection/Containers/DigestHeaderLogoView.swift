//
//  DigestHeaderLogoView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestHeaderLogoView: View {
    var viewModel: TopPicksViewModel.TopPick
    @State private var isLongPressing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DigestSubtitleView(subtitle: viewModel.subtitle)
            VStack {
                HStack {
                    AppleLogoView()
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


struct DigestHeaderLogoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.TopPick(modelType: .headerLogoView,
                                                  title: "Maribou State, OTR, Cathing Flies, RKCB, Hazey Eyes, Isabel, Utah, TRACE, Moglii, Filous, Harrison Brome",
                                                  subtitle: "Made for You",
                                                  imageUrl: "http://192.168.1.7:8887/madeForYou2.png",
                                                  contentString: "chill \nmix".uppercased())
        DigestHeaderLogoView(viewModel: viewModel)
    }
}

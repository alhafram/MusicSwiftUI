//
//  DigestPlainView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestPlainView: View {
    var viewModel: MusicModel
    @State private var isLongPressing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            DigestTitleView(subtitle: viewModel.title ?? "")
            ZStack {
                VStack {}
                .background {
                    BackgroundImageView(imageUrlString: viewModel.url, cornerRadius: 12, size: .init(width: 300, height: 300))
                }
                DigestDetailsView(title: viewModel.details ?? "", footerUrl: viewModel.footerUrl)
                    .padding(.top, 250)
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
        DigestPlainView(viewModel: MusicModel(url: ""))
    }
}

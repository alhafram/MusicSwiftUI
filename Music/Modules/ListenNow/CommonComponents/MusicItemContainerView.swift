//
//  MusicItemView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct MusicItemView: View {
    var viewModel: TopPicksViewModel.MusicItem
    @State private var isLongPressing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {}
            .frame(width: 150, height: 150)
            .background {
                BackgroundImageView(imageUrlString: viewModel.imageUrl, cornerRadius: 12, size: .init(width: 150, height: 150))
            }
            Text(viewModel.title)
                .font(.system(size: 16))
                .lineLimit(1)
            Text(viewModel.subtitle)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .lineLimit(1)
        }
        .frame(width: 150)
        .scaleEffect(isLongPressing ? 0.95 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
            withAnimation {
                isLongPressing = isPressing
            }
        }) {}
    }
}

struct MusicItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TopPicksViewModel.MusicItem(title: "WTF (feat. Amber Van Day) - Single",
                                    subtitle: "HUGEL",
                                    imageUrl: "http://192.168.1.7:8887/recently1.png")
        MusicItemView(viewModel: viewModel)
    }
}

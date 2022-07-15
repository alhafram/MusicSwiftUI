//
//  AlbumView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI

struct AlbumView: View {
    
    @State var item: AlbumChartViewModel.Item
    @State private var isLongPressing = false
    
    private let imageSize: CGFloat = 300
    
    private var backgroundImageUrl: URL? {
        item.artwork?.url(width: Int(imageSize), height: Int(imageSize))
    }
    
    private var footerView: some View {
        ZStack(alignment: .center) {
            VStack { }
                .frame(width: imageSize, height: 80)
                .background(item.artwork?.bgColor)
                .cornerRadius(12)
            VStack {
                Text(item.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(item.artwork?.textColor)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                Text(item.artistName)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(item.artwork?.secondTextColor)
            }
            .frame(width: imageSize)
        }
        .padding(.top, -30)
    }
    
    private var backgroundImage: some View {
        VStack {}
            .frame(width: imageSize, height: imageSize)
            .background {
                CachedAsyncImage(url: backgroundImageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: imageSize, height: imageSize)
                .cornerRadius(12)
            }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            backgroundImage
            footerView
        }
        .scaleEffect(isLongPressing ? 0.95 : 1.0)
        .onTapGesture {
            // TODO: - Then open album content
            print("Open album")
        }
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
            withAnimation {
                isLongPressing = isPressing
            }
        }) {}
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(item: AlbumChartViewModel.Item(artistName: "", title: ""))
    }
}

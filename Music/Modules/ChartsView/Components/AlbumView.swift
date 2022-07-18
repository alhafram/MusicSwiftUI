//
//  AlbumView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI

struct AlbumView: View {
    
    @EnvironmentObject private var router: Router
    
    @State var item: AlbumChartViewModel.Item
    
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
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(item.artwork?.textColor)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                Text(item.artistName)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(item.artwork?.secondTextColor)
            }
            .frame(width: imageSize)
        }
        .padding(.top, -30)
    }
    
    private var backgroundImageView: some View {
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
            backgroundImageView
            footerView
        }
        .onTapGesture {
            router.showMusicBar.toggle()
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(item: AlbumChartViewModel.Item(artistName: "", title: ""))
    }
}

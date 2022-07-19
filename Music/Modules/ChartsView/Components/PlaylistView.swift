//
//  PlaylistView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI

struct PlaylistView: View {
    
    @EnvironmentObject private var router: Router
    
    @State var item: ChartViewModelItem
    
    private let imageSize: CGFloat = 200
    
    private var backgroundImageUrl: URL? {
        item.artwork?.url(width: Int(imageSize), height: Int(imageSize))
    }
    private var backgroundImageView: some View {
        return VStack {}
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
    
    private var titleView: some View {
        Text(item.title)
            .font(.system(size: 16, weight: .semibold))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .foregroundColor(Color.gray)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            backgroundImageView
            titleView
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(item: ChartViewModelItem(title: ""))
    }
}

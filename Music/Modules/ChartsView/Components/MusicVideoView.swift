//
//  MusicVideoView.swift
//  Music
//
//  Created by Albert on 15.07.2022.
//

import SwiftUI

struct MusicVideoView: View {
    
    @EnvironmentObject private var router: Router
    
    @State var item: MusicVideoChartViewModel.Item
    
    private let imageSize: CGFloat = 300
    
    private var backgroundImageUrl: URL? {
        item.artwork?.url(width: item.artwork?.maximumWidth ?? 0, height: item.artwork?.maximumWidth ?? 0)
    }
    
    private var titleView: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .foregroundColor(Color.gray)
                .font(.body)
            Text(item.artistName)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .foregroundColor(Color.gray)
                .font(.subheadline)
        }
        .frame(width: imageSize, alignment: .leading)
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
            titleView
        }
    }
}

struct MusicVideoView_Previews: PreviewProvider {
    static var previews: some View {
        MusicVideoView(item: MusicVideoChartViewModel.Item(artistName: "", title: ""))
    }
}

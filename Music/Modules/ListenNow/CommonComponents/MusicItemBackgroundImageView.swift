//
//  MusicItemBackgroundImageView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct MusicItemBackgroundImageView: View {
    var imageUrlString: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }
        .frame(width: 150, height: 150)
        .cornerRadius(12)
    }
}

struct MusicItemBackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemBackgroundImageView(imageUrlString: "")
    }
}

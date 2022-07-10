//
//  TopPicksBackgroundImageView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksBackgroundImageView: View {
    var imageUrlString: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 300)
        } placeholder: {
            Color.gray
        }
        .frame(width: 250, height: 300)
        .cornerRadius(12)
    }
}

struct TopPicksBackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        TopPicksBackgroundImageView(imageUrlString: "")
    }
}

//
//  DigestBackgroundImageView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestBackgroundImageView: View {
    var imageUrlString: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }
        .frame(width: 300, height: 400)
        .cornerRadius(12)
    }
}

struct DigestBackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        DigestBackgroundImageView(imageUrlString: "")
    }
}

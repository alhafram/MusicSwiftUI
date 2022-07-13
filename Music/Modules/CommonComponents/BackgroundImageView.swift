//
//  BackgroundImageView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct BackgroundImageView: View {
    var imageUrlString: String
    var cornerRadius: CGFloat = 0.0
    var size: CGSize
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }
        .frame(width: size.width, height: size.height)
        .cornerRadius(cornerRadius)
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView(imageUrlString: "", size: .zero)
    }
}

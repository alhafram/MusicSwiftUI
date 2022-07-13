//
//  DigestTitleView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestDetailsView: View {
    var title: String
    var footerUrl: String?
    var body: some View {
        VStack {
            Text(title)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.body)
                .foregroundColor(Color.white)
                .padding(10)
        }
        .frame(width: 300, height: 100)
        .background {
            AsyncImage(url: URL(string: footerUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .brightness(-0.3)
            } placeholder: {
                Color.gray
            }
        }
        .cornerRadius(12)
    }
}

struct DigestTitleView_Previews: PreviewProvider {
    static var previews: some View {
        DigestDetailsView(title: "", footerUrl: "")
    }
}

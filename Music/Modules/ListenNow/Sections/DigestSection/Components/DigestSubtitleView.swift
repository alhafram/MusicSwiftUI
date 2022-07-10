//
//  DigestSubtitleView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct DigestSubtitleView: View {
    var subtitle: String
    var body: some View {
        Text(subtitle)
            .font(.headline)
            .foregroundColor(.gray)
    }
}

struct DigestSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        DigestSubtitleView(subtitle: "")
    }
}

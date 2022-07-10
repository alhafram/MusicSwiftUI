//
//  TopPickSubtitleView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPickSubtitleView: View {
    var subtitle: String
    var body: some View {
        Text(subtitle)
            .font(.headline)
            .foregroundColor(.gray)
    }
}

struct TopPickSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        TopPickSubtitleView(subtitle: "")
    }
}

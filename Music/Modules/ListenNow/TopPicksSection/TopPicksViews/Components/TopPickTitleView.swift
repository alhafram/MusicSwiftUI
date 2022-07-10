//
//  TopPickTitleView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPickTitleView: View {
    var title: String
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .font(.body)
                    .foregroundColor(Color.white)
                    .padding(10)
            }
            .frame(width: 250, height: 100)
            .background(Color.black.opacity(0.6))
            .cornerRadius(12)
            .zIndex(1)
        }
    }
}

struct TopPickTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TopPickTitleView(title: "")
    }
}

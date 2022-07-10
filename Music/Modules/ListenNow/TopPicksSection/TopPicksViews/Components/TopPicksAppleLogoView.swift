//
//  TopPicksAppleLogoView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct TopPicksAppleLogoView: View {
    var body: some View {
        Image(systemName: "apple.logo")
            .foregroundColor(Color.white)
        Text("Music")
            .foregroundColor(Color.white)
    }
}

struct TopPicksAppleLogoView_Previews: PreviewProvider {
    static var previews: some View {
        TopPicksAppleLogoView()
    }
}

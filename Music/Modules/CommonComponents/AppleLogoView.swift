//
//  AppleLogoView.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import SwiftUI

struct AppleLogoView: View {
    var body: some View {
        Image(systemName: "apple.logo")
            .foregroundColor(Color.backgroundColor)
        Text("Music")
            .foregroundColor(Color.backgroundColor)
    }
}

struct AppleLogoView_Previews: PreviewProvider {
    static var previews: some View {
        AppleLogoView()
    }
}

//
//  ListenNowView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct ListenNowView: View {
    var body: some View {
        NavigationView {
            List {
                TopPicksSection()
            }
            .navigationTitle("Listen now")
        }
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}

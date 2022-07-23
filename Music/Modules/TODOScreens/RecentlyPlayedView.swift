//
//  RecentlyPlayedView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct RecentlyPlayedView: View {
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello world")
            }
            .navigationTitle("Recently played")
        }
    }
}

struct RecentlyPlayedView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyPlayedView()
    }
}

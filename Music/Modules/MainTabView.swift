//
//  MainTabView.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var listenNowSettings: ListenNowSettings
    
    var body: some View {
        TabView {
            ListenNowView()
                .tabItem {
                    Label("Listen now", systemImage: "play.circle.fill")
                }
                .environmentObject(listenNowSettings)
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "square.and.pencil")
                }
            RadioView()
                .tabItem {
                    Label("Radio", systemImage: "radio")
                }
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "library")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "search")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(ListenNowSettings())
    }
}

//
//  ContentView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    var body: some View {
        TabView {
            ListenNowView()
                .tabItem {
                    Label("Listen now", systemImage: "list.dash")
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

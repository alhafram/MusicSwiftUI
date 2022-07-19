//
//  MainTabView.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import SwiftUI
import Combine

struct MainTabView: View {
    
    @StateObject private var musicManager = MusicManager()
    @EnvironmentObject private var router: Router
    @AppStorage("selection") private var selection = 0
    
    var body: some View {
        TabView(selection: .constant(selection)) {
            ChartsView()
                .onAppear {
                    selection = 0
                }
                .tabItem {
                    Label("Top Charts", systemImage: "chart.line.uptrend.xyaxis")
                }
                .environmentObject(router)
                .environmentObject(musicManager)
                .tag(0)
            RecentlyPlayedView()
                .onAppear {
                    selection = 1
                }
                .tabItem {
                    Label("Recently played", systemImage: "arrow.counterclockwise.circle")
                }
                .environmentObject(router)
                .tag(1)
            RecommendationsView()
                .onAppear {
                    selection = 2
                }
                .tabItem {
                    Label("Recomendations", systemImage: "radio")
                }
                .tag(2)
            LibraryView()
                .onAppear {
                    selection = 3
                }
                .tabItem {
                    Label("Library", systemImage: "music.note.list")
                }
                .tag(3)
                .accentColor(Color.red)
        }
        .onAppear {
            musicManager.startObserving()
        }
        .overlay(alignment: .bottom) {
            if musicManager.musicItem != nil {
                MusicBar()
                    .environmentObject(musicManager)
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

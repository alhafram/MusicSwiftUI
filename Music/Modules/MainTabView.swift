//
//  MainTabView.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import SwiftUI
import Combine
import MusicKit

struct MainTabView: View {
    
    @StateObject private var musicManager = MusicManager()
    @EnvironmentObject private var router: Router
    @AppStorage("selection") private var selection = 0
    
    @State private var store = Set<AnyCancellable>()
    
    private var song: Song? {
        guard let data = UserDefaults.standard.data(forKey: "song") else { return nil }
        return try? JSONDecoder().decode(Song.self, from: data)
    }
    
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
            guard let song else { return }
            musicManager.musicItem = MusicConfig(item: song, play: false)
        }
        .onReceive(musicManager.$musicItem, perform: { output in
            output.publisher
                .compactMap { config -> Data? in
                    let song = config.item as? Song
                    let data = try? JSONEncoder().encode(song)
                    return data
                }
                .sink { data in
                    UserDefaults.standard.set(data, forKey: "song")
                }
                .store(in: &store)
        })
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

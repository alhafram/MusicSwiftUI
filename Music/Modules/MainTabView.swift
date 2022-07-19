//
//  MainTabView.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import SwiftUI

struct MainTabView: View {
    
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
        
        .overlay(alignment: .bottom) {
            musicBar
        }
    }
    
    @ViewBuilder
    var musicBar: some View {
        if router.showMusicBar {
            HStack {
                VStack {
                    
                }
                .frame(width: 50, height: 50)
                .background(.red)
                .cornerRadius(4)
                .padding()
                Text("Some song name")
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "pause")
                }
                .padding()
                Button {
                    print("Backward")
                } label: {
                    Image(systemName: "forward")
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: 70)
            .background(.gray)
            .foregroundColor(.white)
            .padding(.bottom, 49)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

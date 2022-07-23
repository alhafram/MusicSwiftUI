//
//  ContentView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI
import MusicKit

struct MainView: View {
    
    @StateObject private var router = Router()
    @StateObject private var musicManager = MusicManager()
    
    var body: some View {
        switch router.route {
        case .launchScreen:
            LaunchScreenView()
                .environmentObject(router)
        case .mainScreen:
            MainTabView()
                .environmentObject(router)
                .environmentObject(musicManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

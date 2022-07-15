//
//  ContentView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI
import CoreData
import MusicKit
import MediaPlayer
import Combine

struct MainView: View {
    
    @ObservedObject private var router = Router()
    @ObservedObject private var musicManager = MusicManager()
    
    var body: some View {
        switch router.route {
        case .launchScreen:
            LaunchScreenView()
                .environmentObject(router)
                .environmentObject(musicManager)
        case .mainScreen:
            MainTabView()
                .environmentObject(router)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

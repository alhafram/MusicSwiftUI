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

class ListenNowSettings: ObservableObject {
    @Published var sections = FileParser.getMusicSections()
}

struct MainView: View {
    
    @ObservedObject var router = Router()
    @State var route = Route.launchScreen
    @StateObject var listenNowSettings = ListenNowSettings()
    
    var body: some View {
        switch router.route {
        case .launchScreen:
            LaunchScreenView()
                .environmentObject(router)
        case .mainScreen:
            MainTabView()
                .environmentObject(listenNowSettings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

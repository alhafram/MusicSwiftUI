//
//  Router.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import SwiftUI
import Combine

enum MainRoute {
    case launchScreen
    case mainScreen
}

class Router: ObservableObject {
    @Published var route = MainRoute.launchScreen
    @Published var showMusicBar = false
}

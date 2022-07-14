//
//  Router.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import SwiftUI
import Combine

enum Route {
    case launchScreen
    case mainScreen
}

protocol Routing {
    associatedtype View: SwiftUI.View
    @ViewBuilder func view() -> View
}


class Router: ObservableObject, Routing {
    
    @Published var route = Route.launchScreen
    
    func view() -> some View {
        switch route {
        case .launchScreen:
            LaunchScreenView()
        case .mainScreen:
            MainView()
        }
    }
}

//class Router: Routing {
//
//    let todo: Binding<Route>
//
//    init(todo: Binding<Route>) {
//        self.todo = todo
//    }
//
//    func view(for route: Route) -> some View {
//        switch route {
//        case .launchScreen:
//            LaunchScreenView()
//        case .mainScreen:
//            MainView()
//        }
//    }
//}

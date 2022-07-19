//
//  LaunchScreenView.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject private var router: Router
    
    @State private var showSettingsButton = false
    @State private var animating = true
    @State private var blinking: Bool = false
    
    var foreverAnimation: Animation {
        Animation
            .linear(duration: 0.75)
            .repeatForever()
    }
    
    var body: some View {
        VStack {
            Spacer()
            AppleLogoView()
                .opacity(blinking ? 0.1 : 1)
                .animation(animating ? foreverAnimation : nil)
                .onAppear {
                    withAnimation {
                        blinking = true
                    }
                }
            if showSettingsButton {
                Spacer()
                Text("Looks like you didn't give permission to AppleMusic!")
                    .multilineTextAlignment(.center)
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } label: {
                    Text("Go to settings")
                }
                .foregroundColor(.buttonColor)
                .padding()
            } else {
                Spacer()
            }
        }
        .task {
            try? await Task.sleep(seconds: 1)
            let status = await MusicManager.getAuthorizationStatus()
            switch status {
            case .notDetermined:
                break
            case .authorized:
                router.route = .mainScreen
            case .restricted, .denied:
                animating = false
                showSettingsButton = true
            @unknown default:
                fatalError()
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

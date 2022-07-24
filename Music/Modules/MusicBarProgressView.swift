//
//  MusicBarProgressView.swift
//  Music
//
//  Created by Albert on 24.07.2022.
//

import SwiftUI
import MusicKit

struct MusicBarProgressView: View {
    
    @EnvironmentObject private var musicManager: MusicManager
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common)
    @State private var playbackTime: TimeInterval = 0.0
    
    private var progressWidth: CGFloat {
        if playbackTime > musicManager.musicDuration {
            return 0
        }
        if musicManager.status == .playing && playbackTime == musicManager.musicDuration {
            return 0
        }
        let newValue = (playbackTime / musicManager.musicDuration) * 150
        if musicManager.status == .paused && Int((newValue.isNaN || newValue.isInfinite) ? 0 : newValue) == 0 {
            return 0
        }
        if musicManager.status == .playing || musicManager.status == .paused {
            return newValue
        }
        return 0
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 150, height: 10)
                .padding(.bottom, 10)
            RoundedRectangle(cornerRadius: 5)
                .fill(.red)
                .background(in: Circle(), fillStyle: FillStyle.init())
                .frame(width: 150, height: 10)
                .offset(x: -150 + progressWidth)
                .mask({
                    RoundedRectangle(cornerRadius: 5)
                })
                .clipped()
                .padding(.bottom, 10)
        }
        .onReceive(timer.autoconnect()) { output in
            self.playbackTime = ApplicationMusicPlayer.shared.playbackTime
        }
    }
}

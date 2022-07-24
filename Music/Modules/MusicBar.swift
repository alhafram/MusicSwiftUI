//
//  MusicBar.swift
//  Music
//
//  Created by Albert on 19.07.2022.
//

import SwiftUI

struct MusicBar: View {
    
    @EnvironmentObject var musicManager: MusicManager
    
    @ViewBuilder
    private var imageView: some View {
        CachedAsyncImage(url: musicManager.songIconUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 50, height: 50)
            case .failure:
                EmptyView()
            case let .success(image):
                image.resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(4)
            @unknown default:
                fatalError()
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var playPauseButton: some View {
        Button {
            if musicManager.status == .playing {
                musicManager.pause()
                return
            }
            if musicManager.status == .paused || musicManager.status == .stopped {
                Task {
                    try await musicManager.start()
                    return
                }
            }
        } label: {
            Image(systemName: musicManager.status == .playing ? "pause" : "play")
                .bold()
        }
        .padding()
    }
    
    private var forwardButton: some View {
        Button {
            Task {
                try await musicManager.playNext()
            }
        } label: {
            Image(systemName: "forward")
                .bold()
        }
        .padding(.trailing, 20)
    }
    
    var body: some View {
        HStack {
            imageView
            VStack(alignment: .leading) {
                Text(musicManager.songTitle)
                    .padding(.top, 15)
                MusicBarProgressView()
            }
            Spacer()
            playPauseButton
            forwardButton
        }
        .frame(width: UIScreen.main.bounds.width, height: 70)
        .background(.gray)
        .foregroundColor(.white)
        .padding(.bottom, 49)
    }
}

struct MusicBar_Previews: PreviewProvider {
    static var previews: some View {
        MusicBar()
            .environmentObject(MusicManager())
    }
}

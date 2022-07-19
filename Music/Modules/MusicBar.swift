//
//  MusicBar.swift
//  Music
//
//  Created by Albert on 19.07.2022.
//

import SwiftUI

class MusicBasProgress: ObservableObject {
    @Published var progressWidth: CGFloat = 0
}

struct MusicBar: View {
    
    @EnvironmentObject var musicManager: MusicManager
    @State var progress = MusicBasProgress()
    
    private var progressWidth: CGFloat {
        if musicManager.musicDuration == 0 || musicManager.status == .stopped {
            progress.progressWidth = 0
            return 0
        }
        let newValue = (musicManager.playbackTime / musicManager.musicDuration) * 150
        if musicManager.status == .paused && Int(newValue) == 0 {
            return progress.progressWidth
        }
        if musicManager.status == .playing || musicManager.status == .paused {
            progress.progressWidth = newValue
            return newValue
        } else {
            return progress.progressWidth
        }
    }
    
    private var imageView: some View {
        CachedAsyncImage(url: musicManager.songIconUrl) { phase in
            phase.image?.resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(4)
                .padding()
        }
    }
    
    private var progressView: some View {
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
    }
    
    private var playPauseButton: some View {
        Button {
            if musicManager.status == .playing {
                musicManager.pause()
            }
            if musicManager.status == .paused || musicManager.status == .stopped {
                Task {
                    await musicManager.resume()
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
            print("Next song")
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
                progressView
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

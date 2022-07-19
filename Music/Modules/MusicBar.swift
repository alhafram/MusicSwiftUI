//
//  MusicBar.swift
//  Music
//
//  Created by Albert on 19.07.2022.
//

import SwiftUI

struct MusicBar: View {
    
    @EnvironmentObject var musicManager: MusicManager
    
    @State private var _prevvProgressWidth: CGFloat = 0
    
    private var progressWidth: CGFloat {
        let newValue = (musicManager.playbackTime / musicManager.musicDuration) * 150
        if musicManager.status == .playing {
            _prevvProgressWidth = newValue
            return newValue
        } else {
            return _prevvProgressWidth
        }
    }
    
    var body: some View {
        HStack {
            VStack { }
            .frame(width: 50, height: 50)
            .background {
                CachedAsyncImage(url: musicManager.songIconUrl)
            }
            .cornerRadius(4)
            .padding()
            VStack(alignment: .leading) {
                Text(musicManager.songTitle)
                    .padding(.top, 15)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 10)
                        .padding(.bottom, 10)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.red)
                        .frame(width: progressWidth, height: 10)
                        .padding(.bottom, 10)
                }
            }
            Spacer()
            Button {
                if musicManager.status == .playing {
                    musicManager.pause()
                }
                if musicManager.status == .paused {
                    Task {
                        await musicManager.resume()
                    }
                }
            } label: {
                Image(systemName: musicManager.status == .playing ? "pause" : "play")
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

struct MusicBar_Previews: PreviewProvider {
    static var previews: some View {
        MusicBar()
            .environmentObject(MusicManager())
    }
}


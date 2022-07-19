//
//  MusicView.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import SwiftUI
import Combine
import MusicKit

struct MusicView: View {
    
    @EnvironmentObject var musicManager: MusicManager
    
    @StateObject var musicViewModel = MusicViewModel()
    @State var currentMusicTime: TimeInterval = 0
    @State var isPlaying = true
    
    var songImage: some View {
        VStack {}
            .background {
                CachedAsyncImage(url: URL(string: ""), content: { image in
                    image
                        .resizable()
                        .frame(width: 300, height: 300)
                }, placeholder: {
                    ProgressView()
                })
            }
            .frame(width: 300, height: 300)
            .cornerRadius(12)
    }
    
    var slider: some View {
        VStack {
//            Slider(value: .constant(musicManager.playbackTime), in: 0...musicViewModel.duration, onEditingChanged: { editing in
//                if editing {
//                    musicViewModel.sliderEditing = editing
//                }
//                if !editing {
//                    musicManager.skipTo(musicViewModel.currentMusicTime)
//                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
//                        musicViewModel.sliderEditing = false
//                    }
//                }
//            })
//            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
//            HStack {
//                Text(musicViewModel.currentMusicTimeString)
//                    .padding(.top, -20)
//                    .font(.callout)
//                    .foregroundColor(Color.gray)
//                Spacer()
//                Text(musicViewModel.remainingMusicTimeString)
//                    .padding(.top, -20)
//                    .font(.callout)
//                    .foregroundColor(Color.gray)
//            }
//            .padding()
        }
    }
    
    var body: some View {
        VStack {
            songImage
            slider
            HStack {
                VStack(alignment: .leading) {
                    Text(musicViewModel.title)
                        .font(.system(size: 18, weight: .semibold))
                    Text(musicViewModel.singer)
                        .font(.body)
                        .foregroundColor(Color.gray)
                }
                .padding()
                Spacer()
            }
            HStack {
                Spacer()
                Button {
                    print("Backward")
                } label: {
                    Image(systemName: "backward")
                        .scaleEffect(.init(3))
                }
                .padding()
                .foregroundColor(Color.buttonColor)
                Spacer()
                Button {
                    if isPlaying {
                        musicManager.pause()
                    } else {
                        Task {
                            await musicManager.resume()
                        }
                    }
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause" : "play")
                        .scaleEffect(.init(3))
                }
                .padding()
                .foregroundColor(Color.buttonColor)
                Spacer()
                Button {
                    print("Backward")
                } label: {
                    Image(systemName: "forward")
                        .scaleEffect(.init(3))
                }
                .padding()
                .foregroundColor(Color.buttonColor)
                Spacer()
                
            }
            .padding()
            
        }
        .task {
            musicViewModel.setup(musicManager: musicManager)
            await musicViewModel.startRandomSong()
        }
        .onDisappear {
            musicManager.stopPlaying()
        }
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
            .environmentObject(MusicManager())
    }
}

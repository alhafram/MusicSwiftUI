//
//  MusicViewModel.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import Combine
import MusicKit

class MusicViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var singer = ""
    @Published var cancelable = Set<AnyCancellable>()
    @Published var duration: TimeInterval = 0
    @Published var sliderEditing = false
    lazy var currentMusicTime = musicManager?.playbackTime ?? 0
    
    private var song: Song? {
        didSet {
            fillProperties()
        }
    }
    
    var musicManager: MusicManager!
    
    var currentMusicTimeString: String {
        currentMusicTime.positionalTime
    }
    
    var remainingMusicTimeString: String {
        (duration - currentMusicTime).positionalTime
    }
    
    func setup(musicManager: MusicManager) {
        self.musicManager = musicManager
    }
    
    func fillProperties() {
        duration = song?.duration ?? 0
        title = song?.title ?? ""
        singer = song?.artistName ?? ""
    }
    
    func startRandomSong() async {
//        song = await musicManager?.getSong()
//        guard let song = song else { return }
//        try? await musicManager.play(song: song)
    }
}

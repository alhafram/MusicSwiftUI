//
//  MusicManager.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import MusicKit

struct MusicManager {

//    @State var mediaPlayer = ApplicationMusicPlayer.shared
    
    var status: MusicAuthorization.Status = .notDetermined

    func authorize() async -> MusicAuthorization.Status {
        let request = await MusicAuthorization.request()
        return request
    }



    func fetch() {
        Task {
//            var req1 = MusicCatalogSearchRequest(term: "Hello", types: [Song.self])
//            req1.limit = 25
//
//            let resp = try? await req1.response()
//            let song = resp?.songs.first!
//            print(song)
//
//            mediaPlayer.queue = [song!]
//            try await self.mediaPlayer.play()

        }
    }
}


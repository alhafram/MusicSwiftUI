//
//  ListenNowView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct ListenNowView: View {
    @EnvironmentObject var listenNowSettings: ListenNowSettings
    
    var body: some View {
        NavigationView {
            List(listenNowSettings.sections, id: \.id) { musicSection in
                switch musicSection.type {
                case .big:
                    DigestMusicSection(title: musicSection.sectionHeader,
                                       items: musicSection.items)
                case .small:
                    MusicItemSection(type: musicSection.sectionHeader == "Recebtly Played" ? .recently : .standart,
                                     title: musicSection.sectionHeader,
                                     items: musicSection.items)
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationTitle("Listen now")
        }
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}

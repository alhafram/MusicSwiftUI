//
//  ListenNowView.swift
//  Music
//
//  Created by Albert on 09.07.2022.
//

import SwiftUI

struct ListenNowView: View {
    
    private let viewModel = TopPicksViewModel(topPicks: [
        TopPicksViewModel.TopPick(modelType: .plainView,
                                  title: "Albert's Station",
                                  subtitle: "Made for You",
                                  imageUrl: "http://192.168.1.7:8887/madeForYou.png"),
        TopPicksViewModel.TopPick(modelType: .headerLogoView,
                                  title: "Maribou State, OTR, Cathing Flies, RKCB, Hazey Eyes, Isabel, Utah, TRACE, Moglii, Filous, Harrison Brome",
                                  subtitle: "Made for You",
                                  imageUrl: "http://192.168.1.7:8887/madeForYou2.png",
                                  contentString: "chill \nmix".uppercased()),
        TopPicksViewModel.TopPick(modelType: .centerTextView,
                                  title: "Frient - Single\nLucky Luke & Gaulling\n2018",
                                  subtitle: "Made from Lucky Luke",
                                  imageUrl: "http://192.168.1.7:8887/moreFromLuckyLuke.png",
                                 contentString: "lucky luke & gaulling friend".uppercased()),
        TopPicksViewModel.TopPick(modelType: .topTrailingLogoView,
                                  title: "Lvly & Similar Artists",
                                  subtitle: "Featuring Vlvly",
                                  imageUrl: "http://192.168.1.7:8887/featuringLvly.png")
    ], recentlyPlayed: [
        TopPicksViewModel.MusicItem(title: "WTF (feat. Amber Van Day) - Single",
                                    subtitle: "HUGEL",
                                    imageUrl: "http://192.168.1.7:8887/recently1.png"),
        TopPicksViewModel.MusicItem(title: "Chill Station",
                                    subtitle: "Apple Music Chill",
                                    imageUrl: "http://192.168.1.7:8887/recently2.png"),
        TopPicksViewModel.MusicItem(title: "Kosandra - Single",
                                    subtitle: "yeanix and Real girl",
                                    imageUrl: "http://192.168.1.7:8887/recently3.png"),
        TopPicksViewModel.MusicItem(title: "Kosandra - Single",
                                    subtitle: "Real girl",
                                    imageUrl: "http://192.168.1.7:8887/recently4.png"),
        TopPicksViewModel.MusicItem(title: "Львица - Single",
                                    subtitle: "RASA",
                                    imageUrl: "http://192.168.1.7:8887/recently5.png")
    ])
    
    var body: some View {
        NavigationView {
            List {
                TopPicksSection(topPicks: viewModel.topPicks)
                MusicItemSection(type: .recently, title: "Recently Played", recentlyPlayed: viewModel.recentlyPlayed)
                    .padding(.top, 10)
                MusicItemSection(type: .standart, title: "Lil Nas X Fans Like", recentlyPlayed: viewModel.recentlyPlayed)
                    .padding(.top, 10)
                MusicItemSection(type: .standart, title: "Stations for You", recentlyPlayed: viewModel.recentlyPlayed)
                    .padding(.top, 10)
                TopPicksSection(topPicks: viewModel.topPicks)
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

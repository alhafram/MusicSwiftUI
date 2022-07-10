//
//  TopPicksViewModel.swift
//  Music
//
//  Created by Albert on 10.07.2022.
//

import Foundation

struct TopPicksViewModel: Hashable {
    
    enum ModelType {
        case headerLogoView
        case plainView
        case topTrailingLogoView
        case centerTextView
    }
    
    struct TopPick: Hashable {
        var modelType: ModelType
        var title: String
        var subtitle: String
        var imageUrl: String
        var contentString: String?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(modelType.hashValue)
            hasher.combine(title)
            hasher.combine(subtitle)
            hasher.combine(imageUrl)
            hasher.combine(contentString)
        }
    }
    
    var topPicks: [TopPick]
}


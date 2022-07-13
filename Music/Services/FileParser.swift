//
//  FileParser.swift
//  Music
//
//  Created by Albert on 13.07.2022.
//

import Foundation

struct FileParser {
    
    static func getMusicSections() -> [MusicSection] {
        let result: MusicResult? = FileParser.parse(fileName: "Music", ext: "json")
        return result?.sections ?? []
    }
    
    static func parse<T: Codable>(fileName: String, ext: String) -> T? {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: ext) else {
            return nil
        }
        guard let fileData = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: fileData)
    }
}

enum MusicType: String, Codable {
    case big
    case small
}

struct MusicResult: Codable {
    var sections: [MusicSection]
}

struct MusicSection: Codable {
    var id: UUID
    
    var sectionHeader: String
    var type: MusicType
    var items: [MusicModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sectionHeader = try container.decode(String.self, forKey: .sectionHeader)
        self.type = try container.decode(MusicType.self, forKey: .type)
        self.items = try container.decode([MusicModel].self, forKey: .items)
        self.id = UUID()
    }
}

struct MusicModel: Codable, Hashable {
    var url: String
    var title: String?
    var subtitle: String?
    var details: String?
    var footerUrl: String?
}

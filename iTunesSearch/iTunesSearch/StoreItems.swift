//
//  StoreItems.swift
//  iTunesSearch
//
//  Created by Derek Stengel on 4/25/24.
//

import Foundation

struct StoreItem: Codable {
    let title: String
    let composer: String
    var kind: String
    var description: String
    let artworkURL100: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case composer = "artistName"
        case kind
        case description = "longDescription"
        case artworkURL100 = "artworkUrl100"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        composer = try values.decode(String.self, forKey: CodingKeys.composer)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artworkURL100 = try values.decode(String.self, forKey: CodingKeys.artworkURL100)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
    
}

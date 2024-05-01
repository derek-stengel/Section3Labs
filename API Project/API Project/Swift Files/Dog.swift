//
//  Dog.swift
//  API Project
//
//  Created by Derek Stengel on 4/30/24.
//

import Foundation

struct Dog {
    var artworkURL100: String
    
    
    enum CodingKeys: String, CodingKey {
        case artworkURL100 = "artworkUrl100"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artworkURL100 = try values.decode(String.self, forKey: CodingKeys.artworkURL100)
    }
}

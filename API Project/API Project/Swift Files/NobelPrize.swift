//
//  NobelPrize.swift
//  API Project
//
//  Created by Derek Stengel on 4/30/24.
//

import Foundation

struct NobelPrize {
    var nobelPrizeWinner: String
    
    
    var np: [NobelPrize] = []
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nobelPrizeWinner = try values.decode(String.self, forKey: CodingKeys.name)
    }
}

//
//  Reps.swift
//  API Project
//
//  Created by Derek Stengel on 4/30/24.
//

import Foundation

struct Representatives {
    var repName: String
    var repState: String
    var repLink: String
    
    
    var reps: [Representatives] = []
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case state = "state"
        case link = "website"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repName = try values.decode(String.self, forKey: CodingKeys.name)
        repState = try values.decode(String.self, forKey: CodingKeys.state)
        repLink = try values.decode(String.self, forKey: CodingKeys.link)
    }
}

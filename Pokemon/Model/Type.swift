//
//  Types.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Type: Codable {
    let slot: Int
    let type: RawType
}

struct RawType: Codable {
    let name: String
    let url: String
}

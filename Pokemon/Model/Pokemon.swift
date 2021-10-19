//
//  Pokemon.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [Type]
    let weight: Int
}

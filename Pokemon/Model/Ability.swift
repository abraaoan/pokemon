//
//  Abilities.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Ability: Codable {
    let ability: RawAbility
    let is_hidden: Bool
    let slot: Int
}

struct RawAbility: Codable {
    let name: String
    let url: String
}

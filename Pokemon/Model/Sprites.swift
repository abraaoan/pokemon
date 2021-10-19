//
//  Sprites.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Sprites: Codable {
    let back_default: String
    let back_female: String
    let back_shiny: String
    let back_shiny_female: String
    let front_default: String
    let front_female: String
    let front_shiny: String
    let front_shiny_female: String
    let other: Other
}

struct Other: Codable {
    let dream_word: DreamWord
    let official_artwork: String
}

struct DreamWord: Codable {
    let front_default: String
    let front_female: String
}

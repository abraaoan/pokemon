//
//  Pokemon.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]?
    let height: Int?
    let id: Int?
    let name: String?
    let sprites: Sprites?
    let types: [Type]?
    let weight: Int?
    
    private enum CodingKeys: String, CodingKey {
        case abilities, height, id, name, sprites, types, weight
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.abilities = try? values.decode([Ability].self, forKey: .abilities)
        self.height = try? values.decode(Int.self, forKey: .height)
        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
        self.sprites = try? values.decode(Sprites.self, forKey: .sprites)
        self.types = try? values.decode([Type].self, forKey: .types)
        self.weight = try? values.decode(Int.self, forKey: .weight)
        
    }
    
}

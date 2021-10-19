//
//  Results.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Api: Codable {
    let results: [Result]
    
    init(results: [Result]) {
        self.results = results
    }
    
}

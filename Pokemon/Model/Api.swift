//
//  Results.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

struct Api: Codable {
    let count: Int
    let next: String
    let results: [Result]
    
    init(count: Int, next: String, results: [Result]) {
        self.count = count
        self.next = next
        self.results = results
    }
    
}

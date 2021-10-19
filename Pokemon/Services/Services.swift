//
//  Services.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation

class Services {
    
    private let pokemonsURL = "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=20"
    private let abRequest = ABRequest()
    
    func getPokemons(completion: (([Result]?, _ hasError: Bool) -> ())? = nil) {
        abRequest.send(url: pokemonsURL) { (data) in
            
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            
            // For debuging
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//            }
            
            let decoder = JSONDecoder()
            
            do {
                let api = try decoder.decode(Api.self, from: jsonData)
                completion?(api.results, false)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

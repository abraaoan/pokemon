//
//  Services.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import Foundation
import UIKit

class Services {
    
    static let shared = Services()
    
    private let pokemonsURL = "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=20"
    private let abRequest = ABRequest()
    
    var lastResult: Api?
    
    func getPokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())? = nil) {
        abRequest.send(url: pokemonsURL) { (data) in
            
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            
            // For debuging
            /*if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            } */
            
            let decoder = JSONDecoder()
            
            do {
                let api = try decoder.decode(Api.self, from: jsonData)
                self.lastResult = api
                
                let group = DispatchGroup()
                var results = [ResultViewModel]()
                
                api.results.forEach { result in
                    
                    group.enter()
                    let resultViewModel = ResultViewModel(result: result)
                    
                    resultViewModel.onDetailLoad = {
                        results.append(resultViewModel)
                        group.leave()
                    }
                }
                
                group.notify(queue: DispatchQueue.global()) {
                    completion?(results, false)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getMorePokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())? = nil) {
        
        guard let url = lastResult?.next else {
            completion?(nil, true)
            return
        }
        
        abRequest.send(url: url) { (data) in
            
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let api = try decoder.decode(Api.self, from: jsonData)
                self.lastResult = api
                
                let group = DispatchGroup()
                var results = [ResultViewModel]()
                
                api.results.forEach { result in
                    
                    group.enter()
                    let resultViewModel = ResultViewModel(result: result)
                    
                    resultViewModel.onDetailLoad = {
                        results.append(resultViewModel)
                        group.leave()
                    }
                }
                
                group.notify(queue: DispatchQueue.global()) {
                    completion?(results, false)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemon(url: String,  completion: ((Pokemon?, _ hasError: Bool) -> ())? = nil) {
        abRequest.send(url: url) { (data) in
            
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: jsonData)
                completion?(pokemon, false)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadImage(url: URL, completion:@escaping (UIImage?, Data?) -> ()) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if error == nil, let data = data {
                completion(UIImage(data: data), data)
            } else {
                completion(nil, nil);
            }
        }
        
        dataTask.resume()
    }
       
    
}

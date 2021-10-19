//
//  ABRequest.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import UIKit

class ABRequest {
    
    var currentUrl: String?
    private(set) var isWorking = false;
    
    init() {
        //
    }
    
    func send(url: String, completion:@escaping (Data?) -> ()) {
        
        self.currentUrl = url
        self.isWorking = true
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if (error == nil && data != nil) {
                completion(data)
            } else {
                completion(nil);
            }
            
            self.isWorking = false
            
        }
        
        dataTask.resume()
    }
    
    static func downloadImage(url: String, completion:@escaping (UIImage?) -> ()) {
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if error == nil, let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil);
            }
        }
        
        dataTask.resume()
    }
}

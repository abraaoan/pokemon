//
//  Favorite.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 19/10/21.
//

import UIKit

class Favorite: NSObject {

    static let shared = Favorite()
    var list: [String]
    private let kFavNSDefault = "kFavNSDefault"
    
    override init() {
        
        self.list = [String]()
        super.init()
        
        self.load()
        
    }
    
    func isFavorite(id: String) -> Bool {
        return self.list.contains(id)
    }
    
    func add(id: String) {
        self.list.append(id)
        self.save()
    }
    
    func remove(id: String) {
        
        if let index = self.list.firstIndex(of: id) {
            self.list.remove(at: index)
        }
        self.save()
    }
    
    private func load() {
        
        let userDefault = UserDefaults.standard
        if let list = userDefault.value(forKey: kFavNSDefault) as? [String] {
            self.list = list
        }
    }
    
    private func save() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(self.list, forKey: kFavNSDefault)
    }
}

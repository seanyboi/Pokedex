//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sean O'Connor on 30/07/2017.
//  Copyright © 2017 Boiz. All rights reserved.
//

import Foundation


//class that will hold all pokemon, helps create pokemon as objects
class Pokemon {
    
    //unwrapped because we know it will exist
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
    }
    
    
}

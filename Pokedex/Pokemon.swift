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
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
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

//
//  PokeCell.swift
//  Pokedex
//
//  Created by Sean O'Connor on 30/07/2017.
//  Copyright © 2017 Boiz. All rights reserved.
//

import UIKit


class PokeCell: UICollectionViewCell {
    
    //connect outlets
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //for each pokecell we will want to make a class of pokemon
    
    var pokemon: Pokemon!
    
    //create a function when we are ready to update each collection view cell
    
    func configureCell(pokemon: Pokemon) {
        
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexID)")
        
        
    }
    
    
}

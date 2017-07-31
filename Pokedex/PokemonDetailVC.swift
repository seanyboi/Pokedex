//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Sean O'Connor on 31/07/2017.
//  Copyright © 2017 Boiz. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    //variable it can be sent into
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLbl.text = pokemon.name

    
        
    }


}

//
//  ViewController.swift
//  Pokedex
//
//  Created by Sean O'Connor on 30/07/2017.
//  Copyright © 2017 Boiz. All rights reserved.
//

import UIKit
import AVFoundation //as working with audio

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //array of pokemon
    var pokemon = [Pokemon]()
    //for search bar function
    var filteredPokemon = [Pokemon]()
    //for music player
    var musicPlayer: AVAudioPlayer!
    //for whether we're in search mode or not
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        parsePokemonCSV()
        initAudio()

    }
    
    //creates audio
    func initAudio() {
        
        //created path for audio player
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        //can cause an error so create a do error
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            //infinite loops
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func parsePokemonCSV() {
        
        //created a path to the .csv file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            //using the parser to pull out the rows
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                //csv either does or not have these values
                //go through each row and pull the id and name
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                //create poke objects and put them into new array
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemon.append(poke)
                
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //reusable identifier and cast as collection cell. We are using dequeue because as there are 718 pokemon we do not want to load all 718 cells. This is reusing cells for how many are loaded and showed at a time.
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            //going to call configureCell from PokeCell and pass in the pokemon we created and take that data and set label and image in main storyboard to whatever is passed in the viewcontroller
            let poke: Pokemon!
            
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    
    }
    
    
    //when you tap on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
            
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
    }
    
    //sets number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if inSearchMode {

            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    //number of collections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    //size of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
    

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        //if playing
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            //use the sender value
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
        
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    //everytime we make a keystroke this will be called
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            //keyboard will go away
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            
            //string that is entered in search bar
            let lower = searchBar.text!.lowercased()
            
            //the filtered pokemon list is going to be equal to the original pokemon list but filtered
            //$0 can be though of a placeholder of any and all objects in roginal pokemon array
            //for each pokemon object we are taking the name value and if what we put in the search bar is contained in that range of names we will put it into the filtered pokemon list.
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil })
            //repopulate collectionview with new data
            collection.reloadData()
            
        }
        
        
    }

    //prepare for the segue and sending any object
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if the identifer is pokemondetailvc
        if segue.identifier == "PokemonDetailVC" {
            //then we create a variable for detailsVC saying the desitination is pokemondetailvc
            if let detailsVC = segue.destination as? PokemonDetailVC {
                //poke is the sender of type pokemon
                if let poke = sender as? Pokemon {
                    //the destination view controller variable pokemon is being set to his variables poke
                    detailsVC.pokemon = poke
                }
            }
        }
        
    }


}


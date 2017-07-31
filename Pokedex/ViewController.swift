//
//  ViewController.swift
//  Pokedex
//
//  Created by Sean O'Connor on 30/07/2017.
//  Copyright © 2017 Boiz. All rights reserved.
//

import UIKit
import AVFoundation //as working with audio

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    //array of pokemon
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        
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
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    
    }
    
    
    //when you tap on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //sets number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
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


}


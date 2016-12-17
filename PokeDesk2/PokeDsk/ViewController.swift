//
//  ViewController.swift
//  PokeDsk
//
//  Created by Lalit on 2016-01-22.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , UISearchBarDelegate{
   
    @IBOutlet weak var searchBars: UISearchBar!
    @IBOutlet weak var collection:UICollectionView!
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBars.delegate = self
        initAudio()
        parsePokemonCSV()
        searchBars.returnKeyType = UIReturnKeyType.Done
    }
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("pokeSound", ofType: "mp3")!
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        
        }catch let err as NSError{
             print(err.debugDescription)
        }
        
    }
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokdexId: pokeId)
                pokemon.append(poke)
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemon.count
        }
        return pokemon.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
           
            let poke :Pokemon!
            
            if inSearchMode{
                poke = filteredPokemon[indexPath.row]
            }else{
                
                poke = pokemon[indexPath.row]
                }
            cell.configureCell(poke)
            return cell
            }
            else{
           return UICollectionViewCell()
        }
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke :Pokemon!
        if inSearchMode{
            poke = filteredPokemon[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
            print(indexPath.row)
        }
        performSegueWithIdentifier("DetailedVC", sender: poke)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailedVC"{
            if let detailVC = segue.destinationViewController as? DetailedVC {
                if let poke = sender as? Pokemon{
                    detailVC.pokes = poke
                }
            }
        }
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBars.text == nil || searchBars.text == ""{
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        }else{
            inSearchMode = true
            let lower = searchBars.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.names.rangeOfString(lower) != nil })
            collection.reloadData()
        
        }
    }
    @IBAction func onMusicPressed(sender: UIButton!) {
        if musicPlayer.playing{
            sender.alpha = 0.5
            musicPlayer.stop()
        }else {
            sender.alpha = 1.0
            musicPlayer.play()
        }
    }


}


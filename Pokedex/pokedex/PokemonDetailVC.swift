//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Manh on 8/1/16.
//  Copyright © 2016 PaperDo. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel! //
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var spattackLbl: UILabel!
    @IBOutlet weak var spdefenseLbl: UILabel!
    
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    @IBOutlet weak var nextEvolutionNameLbl: UILabel!
    @IBOutlet weak var nextEvolutionMethodLbl: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImg.hidden = true
        nextEvolutionImg.hidden = true
        nextEvolutionNameLbl.hidden = true
        nextEvolutionMethodLbl.hidden = true
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }

    }

    func updateUI() {
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        idLbl.text = "\(pokemon.pokedexId)"
        mainImg.hidden = false
        
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        hpLbl.text = pokemon.hp
        speedLbl.text = pokemon.speed
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        spattackLbl.text = pokemon.spattack
        spdefenseLbl.text = pokemon.spdefense
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolution"
            nextEvolutionImg.hidden = true
            nextEvolutionNameLbl.hidden = true
            nextEvolutionMethodLbl.hidden = true
        }
        else {
            nextEvolutionImg.image = UIImage(named: pokemon.nextEvolutionId)
            nextEvolutionImg.hidden = false
            
            if pokemon.nextEvolutionName != "" {
                nextEvolutionNameLbl.text = pokemon.nextEvolutionName
            }
            if pokemon.nextEvolutionMethod != "" {
                nextEvolutionMethodLbl.text = "LVL - \(pokemon.nextEvolutionMethod)"
            }
            if pokemon.nextEvolutionMethod == "" {
                nextEvolutionMethodLbl.text = "Stone"
            }
            
        }
        
        
            
          
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

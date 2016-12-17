//
//  DetailedVC.swift
//  PokeDsk
//
//  Created by Lalit on 2016-01-25.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {
    @IBOutlet weak var nameLabel:UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
 
    
    @IBOutlet weak var mainDescriptions: UILabel!
   
    @IBOutlet weak var attack: UILabel!
    
    @IBOutlet weak var weight: UILabel!
    
    @IBOutlet weak var nextEvolution: UILabel!
    
    @IBOutlet weak var futureEvo: UIImageView!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var defence: UILabel!
    
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet weak var pokedexId: UILabel!
    
    var pokes : Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokes.names.capitalizedString
      let img  = UIImage(named: "\(pokes.pokdedexIds)")
        mainImage.image = img
        currentEvo.image = img
        
        pokes.downloadPokemonDetails { () -> () in
           self.updateUI()
        }
    }
    func updateUI(){
        mainDescriptions.text = pokes.description
        type.text = pokes.type
        defence.text = pokes.defence
        height.text = pokes.height
        weight.text = pokes.weight
        attack.text = pokes.attack
        pokedexId.text = "\(pokes.pokdedexIds)"
        
        if pokes.nextEvolutionId == ""{
            nextEvolution.text = "No Evolutions"
            futureEvo.hidden = true
        }
        else{
            futureEvo.hidden = false
            futureEvo.image = UIImage(named: "\(pokes.nextEvolutionId)")
           
            var str = "Next Evolution: \(pokes.nextEvotext)"
            if pokes.nextEvoLevel != ""{
                str += "-LVL \(pokes.nextEvoLevel)"
                nextEvolution.text = str
            }
            
        }
        
        
        
        
    }

    @IBAction func onBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

//
//  PokeCell.swift
//  pokedex
//
//  Created by Manh on 8/1/16.
//  Copyright © 2016 PaperDo. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!

    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        idLbl.text = "\(self.pokemon.pokedexId)"
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}

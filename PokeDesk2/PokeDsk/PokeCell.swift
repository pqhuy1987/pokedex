//
//  PokeCell.swift
//  PokeDsk
//
//  Created by Lalit on 2016-01-24.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    
    var pokemon:Pokemon!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(pokemon:Pokemon){
        self.pokemon = pokemon
   //print(self.pokemon.names)
        nameLabel.text = self.pokemon.names.capitalizedString
    thumbImg.image = UIImage(named:"\(self.pokemon.pokdedexIds)")
        
    }
    
}

//
//  Pokemon.swift
//  pokedex
//
//  Created by Manh on 8/1/16.
//  Copyright © 2016 PaperDo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {

    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    
    private var _hp: String!
    private var _speed: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _spattack: String!
    private var _spdefense: String!
    
    private var _nextEvolutionId: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionMethod: String!

    private var _pokemonUrl: String!
    
    
    // MARK: Getters and Setters
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var hp: String {
        if _hp == nil {
            _hp = ""
        }
        return _hp
    }
    var speed: String {
        if _speed == nil {
            _speed = ""
        }
        return _speed
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = nil
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var spattack: String {
        if _spattack == nil {
            _spattack = ""
        }
        return _spattack
    }
    var spdefense: String {
        if _spdefense == nil {
            _spdefense = ""
        }
        return _spdefense
    }
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var nextEvolutionMethod: String {
        if _nextEvolutionMethod == nil {
            _nextEvolutionMethod = ""
        }
        return _nextEvolutionMethod
    }
    
    
    // MARK: Init method
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
        
        
    }
    
    // MARK: downloading and parsing JSON data
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let hp = dict["hp"] as? Int {
                    self._hp = "\(hp)"
                }
                if let speed = dict["speed"] as? Int {
                    self._speed = "\(speed)"
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }

                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let spattack = dict["sp_atk"] as? Int {
                    self._spattack = "\(spattack)"
                }
                if let spdefense = dict["sp_def"] as? Int {
                    self._spdefense = "\(spdefense)"
                }
                
                print("hp: " + self._hp)
                print("speed: " + self._speed)
                print("weight: " + self._weight)
                print("height: " + self._height)
                print("attack: " + self._attack)
                print("defense: " + self._defense)
                print("spatk: " + self._spattack)
                print("spdef: " + self._spdefense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                }
                else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                        
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    let newDesciption = description.stringByReplacingOccurrencesOfString("POKMON", withString: "pokemon")
                                    self._description = newDesciption
                                    print("Description:" + self._description)
                                }
                                
                            }

                            
                            completed()
                        }
                    }
                }
                else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    // "to" is also the name
                    if let to = evolutions[0]["to"] as? String {
                        
                        // excluding mega evolutions
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                
                                let nextEvoId = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                               
                                self._nextEvolutionId = nextEvoId
                                self._nextEvolutionName = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                  self._nextEvolutionMethod = "\(lvl)"
                                }
                                
                                print("EvoID: " + self._nextEvolutionId)
                                print("EvoName: " + self._nextEvolutionName)
                                //print("EvoMethod: " + self._nextEvolutionMethod)
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            }
        }
        
    }
    
}




















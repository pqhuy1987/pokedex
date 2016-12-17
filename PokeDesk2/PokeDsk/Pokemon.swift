//
//  Pokemon.swift
//  PokeDsk
//
//  Created by Lalit on 2016-01-24.
//  Copyright © 2016 Bagga. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{

    private var _name:String!
    private var _pokdedexId:Int!
    private var _descriptions:String!
    private var _type:String!
    private var _defence:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionName:String!
    private var _nextEvolutionId:String!
    private var _pokemonUrl:String!
    private var _nextEvoLevel:String!
    
    
    var nextEvolutionId:String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var nextEvoLevel:String{
        
        if _nextEvoLevel == nil{
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    var weight:String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    var attack:String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    var nextEvotext:String{
        if _nextEvolutionName == nil{
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var description:String{
        if _descriptions == nil {
            _descriptions = nil
        }
        return _descriptions
    }
    var type:String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    var defence:String{
        if _defence == nil{
            _defence = ""
        }
        return _defence
    }
    
    var height:String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    
    init(name:String,pokdexId:Int){
        _name = name
        _pokdedexId = pokdexId
        _pokemonUrl = "\(BASEURL)\(POKEMONURL)\(pokdedexIds)"
    }
    func downloadPokemonDetails(complete:DownloadComplete){
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
           // print(result.value.debugDescription)
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    self._defence = "\(defense)"
                }
                print(self._height)
                print(self._attack)
                print(self._weight)
                print(self._defence)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    //print(types.debugDescription)
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    if types.count > 1
                    {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                else{
                    self._type = ""
                }
                //print(self._type)
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0{
                    if let to = evolutions[0]["to"] as? String{
                        //Can't Support mega now
                        if to.rangeOfString("mega") == nil{
                            if let uri = evolutions[0]["resource_uri"] as? String?{
                                let newStr = uri?.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr?.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionName = to
                                self._nextEvolutionId = num
                                
                                if let level = evolutions[0]["level"] as? Int{
                                    self._nextEvoLevel = "\(level)"
                                }
                              //  print(self._nextEvoLevel)
                              //  print(self._nextEvolutionId)
                               // print(self._nextEvolutionName)
                            }
                        }
                    }
                    
                }
                if let description = dict["descriptions"] as? [Dictionary<String,String>] where description.count > 0 {
                    if let URL = description[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(BASEURL)\(URL)")!
                        print (nsurl)
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                        
                            let descResult = response.result
                            if let descDict = descResult .value as? Dictionary<String,AnyObject>{
                                if let newDesc = descDict["description"] as? String{
                                    self._descriptions = newDesc
                                    print(self._descriptions)
                                }
                            }
                            complete()
                        }
                        
                    }
                    else{
                        self._descriptions = ""
                    }
                  
                    
                    
                }
               
            }
            
            
        }
        
    
    }
    var names:String{
        get{
            return _name
            
        }
    }
    var pokdedexIds:Int{
        get{
            return _pokdedexId
        }
    }
}

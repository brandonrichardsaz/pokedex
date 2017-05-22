//
//  Pokemon.swift
//  Pokedex
//
//  Created by Richards, Brandon S. on 5/18/17.
//  Copyright © 2017 Richards, Brandon S. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    private var _nextEvoID: String!
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    

    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var pokedexID: Int {
        if _pokedexID == nil {
            _pokedexID = 0
        }
        return _pokedexID
    }
    
    var nextEvoID: String {
        if _nextEvoID == nil  {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"

    }
    
    
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
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
                
                
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                else {
                    self._type = ""
                }
                

                
                //Description
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] , descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let descriptionURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    
                                    let newDesciption = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDesciption
                                    print(newDesciption)
                                }
                            }
                            completed()
                        })
                    }
                }
                else {
                    self._description = ""
                }
                //End of Description
                
                //Start of Next Evolution
                if let evoArr = dict["evolutions"] as? [Dictionary<String,AnyObject>] , evoArr.count > 0 {
                    if let level = evoArr[0]["level"] as? Int , let toEvo = evoArr[0]["to"] as? String , let resourceUIR = evoArr[0]["resource_uri"] {
                        
                        let resourceArr = resourceUIR.components(separatedBy: "/")
                        print("HELLLLLLO \(resourceArr)")
                        
                        self._nextEvolutionText = "Next Evolution \(toEvo) Level \(level)"
                        
                        self._nextEvoID = resourceArr[4]
                    }
                    else {
                        print("DID NOT MAKE IT IN")
                    }
                }
                else {
                    self._nextEvolutionText = ""
                }
                

            }
            
            completed()
        }
    }
}

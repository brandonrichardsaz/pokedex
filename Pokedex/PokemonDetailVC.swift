//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Richards, Brandon S. on 5/20/17.
//  Copyright © 2017 Richards, Brandon S. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    var pokemon: Pokemon!
    
    //private
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var evoText: UILabel!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = img
        currentEvoImage.image = img
        pokedexLbl.text = "\(pokemon.pokedexID)"
        
        
        
        
        pokemon.downloadPokemonDetails {
            //whatever we write here will only be called after the network call is complete
            self.updateUI()
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func updateUI() {
        print("NEXT ID \(pokemon.nextEvoID)")
        
        if pokemon.nextEvoID != ""
        {
            nextEvoImage.isHidden = false
            let image = UIImage(named: "\(pokemon.nextEvoID)")
            nextEvoImage.image = image
            evoText.text = pokemon.nextEvolutionText
        }
        else {
            evoText.text = ""
            nextEvoImage.isHidden = true
        }
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

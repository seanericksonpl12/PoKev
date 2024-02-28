//
//  CardViewModel.swift
//  PoKev
//
//  Created by Kevin Kokal on 1/28/24.
//

import Foundation
import Observation
import SwiftUI

final class CardViewModel {
    let card: PokemonTCGCard
    let set: PokemonTCGSet
    let shouldShowPokedexButton: Bool

    var imageURL: URL? {
        if let urlString = card.images.small {
            return URL(string: urlString)
        }
        return nil
    }
    
    var tcgPlayerURL: URL? {
        if let urlString = card.tcgplayer?.url {
            return URL(string: urlString)
        }
        return nil
    }
    
    var cardTitle: String {
        return card.name
    }
    
    var cardSubtitle: String {
       return "(\(card.number)/\(set.printedTotal))"
    }
    
    var highlightColor: Color? {
        let highlightColor = Color("HighlightedCard")
        
        return card.isPotentialDeal ? highlightColor : nil
    }
    
    init(card: PokemonTCGCard, set: PokemonTCGSet, shouldShowPokedexButton: Bool) {
        self.card = card
        self.set = set
        self.shouldShowPokedexButton = shouldShowPokedexButton
    }
}

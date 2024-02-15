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
    
    var backgroundColor: Color {
        let defaultColor = Color.white
        
        if let holofoilPriceData = card.tcgplayer?.prices?.holofoil, let directLow = holofoilPriceData.directLow, let market = holofoilPriceData.market {
            return directLow <= market ? Color(hex: 0xFDFD96) : defaultColor
        } else {
            let apiDateFormatter = DateFormatter()
            apiDateFormatter.dateFormat = "yyyy/MM/dd"
            
            if let date = apiDateFormatter.date(from: set.releaseDate), let xyDate = apiDateFormatter.date(from: "2014/02/05") {
                if date < xyDate {
                    if let normalPriceData = card.tcgplayer?.prices?.normal, let directLow = normalPriceData.directLow, let market = normalPriceData.market {
                        return (directLow <= market && directLow >= market * 0.6) ? Color(hex: 0xFDFD96) : defaultColor
                    } else if let revereHolofoilPriceData = card.tcgplayer?.prices?.reverseHolofoil, let directLow = revereHolofoilPriceData.directLow, let market = revereHolofoilPriceData.market {
                        return (directLow <= market && directLow >= market * 0.6) ? Color(hex: 0xFDFD96) : defaultColor
                    }
                }
            }
        }
        
        return Color.white
    }
    
    init(card: PokemonTCGCard, set: PokemonTCGSet) {
        self.card = card
        self.set = set
    }
}
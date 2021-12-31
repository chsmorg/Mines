//
//  Cards.swift
//  Mines
//
//  Created by chase morgan on 12/29/21.
//

import Foundation
import SwiftUI



func makeDeck() -> [Card]{
    let cardType = ["club","diamond","heart","spade"]
    var cards: [Card] = []
    let cardImgs = loadImgPaths().sorted{
        
        // number of elements in each array
        let c1 = $0.pathComponents.count - 1
        let c2 = $1.pathComponents.count - 1

        // the filename of each file
        let v1 = $0.pathComponents[c1]
        let v2 = $1.pathComponents[c2]
        
        return v1.caseInsensitiveCompare(v2) == .orderedAscending
     }
    
    
    
    var cardNum = 1
    var cT = 0
    
    for i in cardImgs{
        var card: Card
        
        if(cardNum == 10){
            card = Card(type: cardType[cT], number: 1, imgPath: i)
        }
        else if(cardNum > 10){
            card = Card(type: cardType[cT], number: 10, imgPath: i)
        }
        else if(cardNum == 1){
            card = Card(type: cardType[cT], number: 10, imgPath: i)
        }
        else{
            card = Card(type: cardType[cT], number: cardNum, imgPath: i)
        }
            
        cards.append(card)
        
        
        if(cT == 3){
            cT = 0
            cardNum += 1
        }
        else{
            cT += 1
        }
    }
    
    return cards
}

func loadImgPaths() -> [URL]{
    var strings: [URL] = []
    
    let path = Bundle.main.resourcePath
            let imagePath = path! + "/cardImgs"
            let url = NSURL(fileURLWithPath: imagePath)
            let fileManager = FileManager.default

            let properties = [URLResourceKey.localizedNameKey,
                          URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
                do {
                    strings = try fileManager.contentsOfDirectory(at: url as URL, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

                    //print("image URLs: \(strings)")
                }
             catch let error1 as NSError {
                    print(error1.description)
            }
    
    return strings
    
}


struct Card{
    var type: String
    var number: Int
    var imgPath: URL
    
}

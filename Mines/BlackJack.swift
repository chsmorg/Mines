//
//  BlackJack.swift
//  Mines
//
//  Created by chase morgan on 12/30/21.
//

import SwiftUI
import Foundation
//Image(uiImage: UIImage(data: Data(contentsOf: cards[0].imgPath))!)
//img.resizable().frame(width: 71.4, height: 103.7)
struct BlackJack: View {
    @State var cards = makeDeck()
    @State var img:[Image] = []
    var body: some View {
        VStack{
            Spacer()
            HStack{
                ForEach(0..<img.count, id: \.self){ card in
                    img[card].resizable().frame(width: 71.4, height: 103.7).scaledToFit()
                }
                
            }
            Spacer()
            
            HStack{
                Button(action: {
                    let ran = Int.random(in: 0...cards.count-1)
                    var data: Data
                    do{
                       try data = Data(contentsOf: cards[ran].imgPath)
                        img.append(Image(uiImage: UIImage(data: data)!))
                        
                    }catch{
                        print("error")
                    }
    
                    
                    
                    },label: {
                    Text("Hit").padding()
                        .foregroundColor(.black)
                        .background (.green)
                        .cornerRadius(15)

                }).padding()
            
            }
            
        }
    }
}

struct BlackJack_Previews: PreviewProvider {
    static var previews: some View {
        BlackJack()
    }
}

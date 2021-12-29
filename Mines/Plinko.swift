//
//  Plinko.swift
//  Mines
//
//  Created by chase morgan on 12/19/21.
//


import SwiftUI
import SpriteKit
import UIKit




struct Plinko: View {
   @State var plinkoExit = false
    @ObservedObject var states: StateVars
   
    var body: some View {
        VStack{
            
            HStack{
                
                Text("Balance: \(states.bal, specifier: "$%.2f")").font(Font.system(size: 15).monospacedDigit()).padding()
                
                Text("Bet Amount: \(states.bet, specifier: "$%.2f")").font(Font.system(size: 15).monospacedDigit()).padding()
                
                Text("Profit: \(states.payOut, specifier: "$%.2f")").font(Font.system(size: 15).monospacedDigit()).padding()
                
               
            }
            
            PlinkoView(states: states, exit: plinkoExit)
            
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    if(!states.plinkoBallsOut.isEmpty){
                        
                        
                        ForEach(0...states.plinkoBallsOut.count-1, id: \.self) { index in
                            ScrollBox(payOut: states.plinkoBallsOut[states.plinkoBallsOut.count-1-index].payOut, multi: states.plinkoBallsOut[states.plinkoBallsOut.count-1-index].multi, betAmount: states.bet)
                                            
                                    }
                    }
                    
                }.padding()
            }
            
            HStack{
                
                Text("Dropped:\n \(states.totalDropped)").font(Font.system(size: 15).monospacedDigit()).padding()
               
                Button(action: {
                    if(states.totalDropped == states.plinkoBallsOut.count)
                    {
                        states.selected = 1
                        StateVars.reset(states: states)
                    }

                    
                },label: {
                    Text("Cash Out!").padding()
                        .foregroundColor(.black)
                        .background (.green)
                        .cornerRadius(10)

                })
                Text("Spent:\n \(states.totalSpent, specifier: "$%.2f")").font(Font.system(size: 15).monospacedDigit()).padding()
            }
        }.navigationTitle("Tap Screen To Drop!")
    }
    
    
}

struct ScrollBox: View{
    
    var payOut: Double
    var multi: Double
    var betAmount: Double
    
    var body: some View{
        Text("+$\(payOut, specifier: "%.2f")\nx\(multi, specifier: "%.2f")    ").foregroundColor(.black).padding().background(RoundedRectangle(cornerRadius: 5).fill(payOut <= betAmount ? .red : .green))
        
        
        
    }
    
}

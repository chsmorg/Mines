//
//  Mines.swift
//  Mines
//
//  Created by chase morgan on 12/19/21.
//

import SwiftUI
import AVFoundation

public struct Mines: View {
    @ObservedObject var states: StateVars
    @State var selected = 0
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()),
        GridItem(.flexible())]
    
    public var body: some View {
        VStack{
            HStack{
                
                Text("Bet Amount: \(states.bet, specifier: "$%.2f")").padding()
                
                Text("Profit: \(states.payOut-states.bet, specifier: "$%.2f")").padding()
                
                Button(action: {

                    states.selected = 0
                    
                    states.bal += states.payOut - states.bet
                    StateVars.reset(states: states)
                },label: {
                    Text("Cash Out!").padding()
                        .foregroundColor(.black)
                        .background (.green)
                        .cornerRadius(10)

                })
                
                
                
                
                
            }.navigationTitle("Mines: \(Int(states.mines))")
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(states.data.indices, id: \.self) {item in
                        BView(cell: states.data[item] ,data: states.data, states: states, selectedBtn: states.pressed)
                        
                        
                    
                    
                        
                    }
                    
    }
        }
    }
}



struct BView: View {
    @State var bomb: AVAudioPlayer?
    @State var diamond: AVAudioPlayer?
    let bombUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "bomb.mp3", ofType:nil)!)
    let diamondUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "diamond.mp3", ofType:nil)!)
    
  var cell: Cell
  var data: [Cell]
  @StateObject var states: StateVars
  @State var selectedBtn: Int
  //@State var gameOver = false
  @State var hit: Bool = false
  var body: some View{
    Button(action: {
        if(states.gamePlay==true){
        
            self.selectedBtn = self.cell.num
            self.hit = true
            if(self.cell.type==0){
                
                states.buttonsHit += 1
                
                states.payOut *= states.multi + (Double(states.buttonsHit)/100)
                do{
                    diamond = try AVAudioPlayer(contentsOf: diamondUrl)
                    diamond?.play()
            } catch {
                // couldn't load file :(
            }
            
                
            }
        
            
            
            if(self.cell.type==1){
                
                print("mine hit")
                states.gamePlay = false
                states.payOut = 0
                do{
                    bomb = try AVAudioPlayer(contentsOf: bombUrl)
                    bomb?.play()
            } catch {
                // couldn't load file :(
            }
                
            }
        

            
        }
        
    }, label: {
        if(cell.type==0){
            cell.img
                .opacity(self.selectedBtn == self.cell.num ? 1 : 0)
               
                .foregroundColor(.green)
                .font (.system (size: 30))
                .frame (minWidth: 0, maxWidth: .infinity, minHeight: 50)
                .background (.gray)
                .cornerRadius(10)
            
        }
        else{
            cell.img
                .opacity(self.selectedBtn == self.cell.num ? 1 : 0)
                .foregroundColor(.red)
                .font (.system (size: 30))
                .frame (minWidth: 0, maxWidth: .infinity, minHeight: 50)
                .background (.gray)
                .cornerRadius(10)
        }
                                 
        })
          .disabled(hit)
        
  }
}




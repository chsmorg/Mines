//
//  ContentView.swift
//  Mines
//
//  Created by chase morgan on 12/19/21.
//
import SwiftUI
import AVFoundation





struct ContentView: View {
    @ObservedObject var states: StateVars = StateVars()
    @State var plinkoExit = false
    
    var body: some View {
        VStack{
                switch states.selected{
                case 0:
                    NavigationView{
                        VStack{
                            Text("Current Balance:\n \(states.bal, specifier: "$%.2f")").font(.system(size: 25, weight: .bold, design: .default)).padding().fixedSize()
                            
                            
                            
                            Slider(value: $states.bet, in: 0...states.bal).accentColor(.green).padding()
                            
                            Text("Bet Amount: \(states.bet, specifier: "$%.2f")").font(.system(size: 20))
                            BetButtons(states: states)
     
                            Slider(value: $states.mines, in: 1...23).accentColor(.green).padding()
                            Text("Amount of Mines: \(Int(states.mines))").font(.system(size: 20))
                            
                            
                            Button(action: {
                                
                                print(makeDeck())
                                if(states.bal != 0 && states.bet != 0){
                                    states.selected = 4
                                    if(states.bet>states.bal){
                                        states.bet=states.bal
                                    }
                                    states.data = Cell.fillMinesList(mines: Int(states.mines))
                                    states.multi = Cell.setMulti(mines: Int(states.mines))
                                    states.payOut = states.bet
                                }
                                
                            },label: {
                                Text("Start").padding()
                                    .foregroundColor(.black)
                                    .background (.green)
                                    .cornerRadius(15)
        
                            }).padding()
                            //Spacer()
                            NavBar(states: states)
                                    
                        }.navigationTitle("Mines")
                       
                        
                    }
                case 1:
                    NavigationView{
                        VStack{
                            
                            
                            Text("Current Balance:\n \(states.bal, specifier: "$%.2f")").font(.system(size: 25, weight: .bold, design: .default)).padding().fixedSize()
                            
                            
                            
                            VStack{
                                
                                if(states.bal >= 2000){
                                    Slider(value: $states.bet, in: 0...2000).accentColor(.green).padding()
                                }
                                else{
                                    Slider(value: $states.bet, in: 0...states.bal).accentColor(.green).padding()
                                }
                                
                                
                                Text("Bet Amount: \(states.bet, specifier: "$%.2f")").font(.system(size: 20))
                                
                                
                                BetButtons(states: states)
                                
                                
                                Slider(value: $states.rows, in: 8...14).accentColor(.green).padding()
                                
                                Text("Rows: \(Int(states.rows))").font(.system(size: 20))
                                
                                Slider(value: $states.risk, in: 0...3).accentColor(.green).padding()
                                switch Int(states.risk){
                                case 0:
                                    Text("Low").font(.system(size: 20))
                                case 1:
                                    Text("Medium").font(.system(size: 20))
                                default:
                                    Text("High").font(.system(size: 20))
                                }
                            }
                            Button(action:
                            {
                                if(states.bal != 0 && states.bet != 0)
                               {
                                    states.selected = 5
                                    plinkoExit = false
                                    if(states.bet>states.bal)
                                    {
                                        states.bet=states.bal
                                    }
                                }
                                
                            },label:{
                                Text("Start").padding()
                                    .foregroundColor(.black)
                                    .background (.green)
                                    .cornerRadius(15)
        
                            }).padding()
                            NavBar(states: states)
                        }.navigationTitle("Plinko")
                    }
                    
                case 2:
                    NavigationView{
                        InfoPage(states: states)
                        //BlackJack()
                    }
                case 4:
                    NavigationView{
                        Mines(states: states)
                    }
                case 5:
                    NavigationView{
                       Plinko(states: states)
                       
                        
                    }
                default:
                    Text("error")
                }
            }
        
    }
            
}

struct BetButtons: View {
    @ObservedObject var states: StateVars
    
    var body: some View {
        var limit = states.bal
        HStack
        {
            
            Button(action:
            {
                if(states.selected == 1 && states.bal >= 2000){
                    limit = 2000
                }
                
                if(states.bet*2<limit)
                {
                    states.bet = states.bet*2
                }
                else{
                    states.bet = limit
                }
               
                
            },label:{
                Text("x2").padding()
                    .foregroundColor(.black)
                    .background (.blue)
                    .cornerRadius(15)

            }).padding()
            
            Button(action:
            {
                if(states.bet * 0.5 >= 0.01)
                {
                    states.bet = states.bet * 0.5
                }
                
               
                
            },label:{
                Text("x1/2").padding()
                    .foregroundColor(.black)
                    .background (.blue)
                    .cornerRadius(15)

            }).padding()
            
            Button(action:
            {
                if(states.selected == 1 && states.bal >= 2000){
                    limit = 2000
                }
                states.bet = limit
               
                
            },label:{
                Text("Max").padding()
                    .foregroundColor(.black)
                    .background (.blue)
                    .cornerRadius(15)

            }).padding()
        }
    }
}

struct NavBar: View{
    @ObservedObject var states: StateVars
    @Environment(\.colorScheme) var colorScheme
    let icons = [
        "diamond.inset.filled",
        "pyramid.fill",
        "questionmark",
    ]
    var body: some View{
        
        VStack{
       Spacer()
        Divider()
       
        HStack{
            
            ForEach(0..<icons.count, id: \.self){ number in
                
                Spacer()
                
                Button(action:{
                    if(number != states.selected){
                        states.selected = number
                        if(states.bet>2000 && number == 1){
                            states.bet = 2000
                        }
                    }
                    
                    
                   
                    
                }, label: {
                    Image(systemName: icons[number])
                        .font(.system(size:25,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                })
                
                Spacer()
            }
        }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}

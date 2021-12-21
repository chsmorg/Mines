//
//  InfoPage.swift
//  Mines
//
//  Created by chase morgan on 12/19/21.
//

import SwiftUI

struct InfoPage: View {
    @ObservedObject var states: StateVars
    var body: some View {
        VStack{
            
            Text("This project is a simple betting game where you specify an amount of mines in a 3x8 grid and try to get as many green diamonds as you can without hitting a red mine. Unfortunately, this project is still a work in progress but most of the core functionality has been built. If you are interested in viewing  the development and finished project, please visit my github page at: https://github.com/chsmorg \n \nChase Morgan.").padding()
            Spacer()
            
            
            Button(action: {
                self.states.bal += 10000
            },label: {
                Text("Add Money").padding()
                    .foregroundColor(.black)
                    .background (.blue)
                    .cornerRadius(15)

            }).padding()
            NavBar(states: states)
            
        }.navigationTitle("About")
        
        
    }
}



//
//  State.swift
//  Mines
//
//  Created by chase morgan on 12/19/21.
//


import Foundation
import SwiftUI


class StateVars: ObservableObject {
    @Published var mines: Double = 1
    @Published var bet: Double = 1
    @Published var bal: Double = 1000
    @Published var multi: Double = 1.00
    @Published var pressed = -1
    @Published var payOut: Double = 0
    @Published var gamePlay: Bool = true
    @Published var buttonsHit: Int = 0
    @Published var rows: Double = 8
    @Published var risk: Double = 0
    @Published var selected = 0
    @Published var data: [Cell] = Cell.fillMinesList(mines: 0)
    @Published var ballsToDrop: Int = 0

    class func reset(states: StateVars){
        states.buttonsHit = 0
        states.gamePlay = true
        states.payOut = 0
        states.multi = 1.00
        
    }
}


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
    @State var balls = 3
    @State var ballSize = 80
    
    @ObservedObject var states: StateVars
    
    
   
    var body: some View {
      
        GeometryReader { geometry in
            ForEach(0..<Int(states.rows), id: \.self){ rowNum in
                ForEach(0..<(balls+Int(rowNum)), id: \.self){ ballNum in
                    if((balls + rowNum) % 2 == 0)
                    {
                        CircleEven(circle_Width: Double(ballSize/Int(states.rows)), circle_Height: Double(ballSize/Int(states.rows)), postion_Width: geometry.size.width, balls: Double(balls+rowNum), ballNum: Double(ballNum), rows: states.rows+1.5, rowNum: Double(rowNum))
                    }
                    
                    else{
                        CircleOdd(circle_Width: Double(ballSize/Int(states.rows)), circle_Height: Double(ballSize/Int(states.rows)), postion_Width: geometry.size.width, balls: Double(balls+rowNum), ballNum: Double(ballNum), rows: states.rows+1.5, rowNum: Double(rowNum))
                    }
                    
                }
                
            }
            ForEach(0..<Int(states.rows)+1, id: \.self){ box in
                Box(postion_Width: geometry.size.width, boxSize: 140, boxs: Double(box), rows: states.rows)
            }
            
            
        }
        
        
        
    }
}

struct CircleEven: View {
    var circle_Width: Double
    @Environment(\.colorScheme) var colorScheme
    var circle_Height: Double
    var postion_Width: Double
    var balls: Double
    var ballNum: Double
    var rows: Double
    var rowNum: Double
    var body: some View{
        
        
        //  ((geometry.size.width/Double(rows) * Double((balls+rowNum)/2)) + (geometry.size.width/Double(rows)) * 0.5)
        Circle().fill(colorScheme == .dark ? Color.white : Color.black).frame(width: circle_Width, height: circle_Height).position(x: (postion_Width * 0.5 - ((postion_Width/rows) * (balls)/2 - postion_Width/rows * 0.5)) + (postion_Width/rows * ballNum)  ,y: postion_Width/rows * 2.0 + postion_Width/rows * rowNum)
    }
}

struct CircleOdd: View {
    var circle_Width: Double
    @Environment(\.colorScheme) var colorScheme
    var circle_Height: Double
    var postion_Width: Double
    var balls: Double
    var ballNum: Double
    var rows: Double
    var rowNum: Double
    var body: some View{
        
        
        
        Circle().fill(colorScheme == .dark ? Color.white : Color.black).frame(width: circle_Width, height: circle_Height).position(x: (postion_Width * 0.5 - (postion_Width/rows) * (balls-1)/2) + (postion_Width/rows * ballNum)  ,y: postion_Width/rows * 2.0 + postion_Width/rows * rowNum)
    }
}
struct Box: View {
    var postion_Width: Double
    var boxSize: Double
    var boxs: Double
    var rows: Double
    var body: some View{
        
        if(boxs < rows/2 + (rows * 0.15) && boxs > rows/2 - (rows * 0.15)){
            RoundedRectangle(cornerRadius: Double(100/rows)).fill(Color.yellow).frame(width: boxSize/(rows/2), height: boxSize/(rows/2))
                .position(x:  postion_Width * 0.5 - (postion_Width/(rows+1.5)) * ((rows)/2) + (postion_Width/(rows+1.5) * boxs), y: postion_Width/rows * 2.0 + postion_Width/rows * (rows-1.8))
        }
        else if(boxs < rows/2 + (rows * 0.35) && boxs > rows/2 - (rows * 0.35)){
            RoundedRectangle(cornerRadius: Double(100/rows)).fill(Color.orange).frame(width: boxSize/(rows/2), height: boxSize/(rows/2))
                .position(x:  postion_Width * 0.5 - (postion_Width/(rows+1.5)) * ((rows)/2) + (postion_Width/(rows+1.5) * boxs), y: postion_Width/rows * 2.0 + postion_Width/rows * (rows-1.8))
        }
        else{
            RoundedRectangle(cornerRadius: Double(100/rows)).fill(Color.red).frame(width: boxSize/(rows/2), height: boxSize/(rows/2))
                .position(x:  postion_Width * 0.5 - (postion_Width/(rows+1.5)) * ((rows)/2) + (postion_Width/(rows+1.5) * boxs), y: postion_Width/rows * 2.0 + postion_Width/rows * (rows-1.8))
        }
        
        
        
    }
    
}


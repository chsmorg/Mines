//
//  Cell.swift
//  Mines
//
//  Created by chase morgan on 12/19/21.
//

import Foundation
import SwiftUI


class Cell: Identifiable {
    var id = UUID()
    var num: Int
    var type: Int
    var img =  Image(systemName: "diamond.inset.filled")
    var vis = false
    var pressed = false
    
    init(num: Int, type: Int, img: Image, vis: Bool, pressed: Bool ){
        self.num = num
        self.type = type
        self.img = img
        self.vis = vis
        self.pressed = pressed
    }
    
    class func ran(list: [Int], mines: Int) -> [Int]{
        var m = mines
        var l = list
        let placement: Int = l.randomElement()!
        let mine = l.firstIndex(of: placement)!
        
        l.remove(at: mine)
        //print(l)
        
        m = m-1
        if(m>0){
            l = ran(list: l, mines: m )
        }
        l.insert(-1, at: mine)
        return l
        
    }
    
    
    class func fillMinesList(mines: Int) -> [Cell]{
        var data = [Cell]()
        //let typeList = Array(repeating: 0, count: 24)
        let typeList = Array(1...24)
        //print(typeList)
        //print(typeList[0])
        let m = mines
        let updatedTypeList = ran(list: typeList, mines: m)
        var num = 0
        for i in updatedTypeList {
            if(i>0){
                data.append(Cell(num: num, type: 0, img: Image(systemName: "diamond.inset.filled"), vis: false, pressed: false))
            }
            else{
                data.append(Cell(num: num, type: 1, img: Image(systemName: "diamond.inset.filled"), vis: false, pressed: false))
            }
            
            num += 1
        }
       
        return data
        
    }
    
    class func setMulti(mines: Int) -> Double {
        var multi: Double = 1.00
        if(mines != 1){
            for i in (1...mines){
                multi *= 1.00 + Double(i)/100
                
            }
        }
        
        return multi
    }
    
    
    
}

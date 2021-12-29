//
//  PlinkoPayOuts.swift
//  Mines
//
//  Created by chase morgan on 12/28/21.
//

import Foundation

class PlinkoPayOuts{
    var rows: Int
    var risk: Int
    
    init(rows: Int, risk: Int){
        if(risk>2){
            self.risk = 2
        }
        else{
            self.risk = risk
        }
        if(rows>14){
            self.rows = 14
        }
        else{
            self.rows = rows
        }
    }
    
    func returnPayOut() -> [Double]{
        var list: [Double] = []
        
        
        switch rows{
        case 8:
            switch risk{
            case 0:
                list = [5.6,2.1,1.1,1.0,0.5,1.0,1.1,2.1,5.6]
            case 1:
                list = [13,3.0,1.3,0.7,0.4,0.7,1.3,3.0,13]
            case 2:
                list = [29,4.0,1.5,0.3,0.2,0.3,1.5,4.0,29]
            default:
                print("error")
            }
        case 9:
            switch risk{
            case 0:
                list = [5.6,2.0,1.6,1.0,0.7,0.7,1.0,1.6,2.0,5.6]
            case 1:
                list = [18,4.0,1.7,0.9,0.5,0.5,0.9,1.7,4.0,18]
            case 2:
                list = [43,7.0,2.0,0.6,0.2,0.2,0.6,2.0,7.0,43]
            default:
                print("error")
            }
        case 10:
            switch risk{
            case 0:
                list = [8.9,3.0,1.4,1.1,1.0,0.5,1.0,1.1,1.4,3.0,8.9]
            case 1:
                list = [22,5,2,1.4,0.6,0.4,0.6,1.4,2,5,22]
            case 2:
                list = [76,10,3.0,0.9,0.3,0.2,0.3,0.9,3,10,76]
            default:
                print("error")
            }
        case 11:
            switch risk{
            case 0:
                list = [8.4,3.0,1.9,1.3,1.0,0.7,0.7,1.0,1.3,1.9,3.0,8.4]
            case 1:
                list = [22,6,3,1.8,0.7,0.5,0.5,0.7,1.8,3,6,24]
            case 2:
                list = [120,14,5.2,1.4,0.4,0.2,0.2,0.4,1.4,5.2,14,120]
            default:
                print("error")
            }
        case 12:
            switch risk{
            case 0:
                list = [10,3.0,1.6,1.4,1.1,1.0,0.5,1.0,1.1,1.4,1.6,3.0,10]
            case 1:
                list = [33,11,4,2,1.1,0.6,0.3,0.6,1.1,2,4,11,33]
            case 2:
                list = [170,24,8.1,2,0.7,0.2,0.2,0.2,0.7,2,8.1,24,170]
            default:
                print("error")
            }
        case 13:
            switch risk{
            case 0:
                list = [8.1,4.0,3,1.9,1.2,0.9,0.7,0.7,0.9,1.2,1.9,3,4.0,8.1]
            case 1:
                list = [43,14,6,3,1.3,0.7,0.4,0.4,0.7,1.3,3,6,13,43]
            case 2:
                list = [260,37,11,4,1,0.2,0.2,0.2,0.2,1,4,11,37,260]
            default:
                print("error")
            }
        case 14:
            switch risk{
            case 0:
                list = [7.1,4.0,1.9,1.4,1.3,1.1,1.0,0.5,1.0,1.1,1.3,1.4,1.9,4,7.1]
            case 1:
                list = [58,15,7,4,1.9,1,0.5,0.2,0.5,1,1.9,4,7,15,58]
            case 2:
                list = [420,56,18,5,1.9,0.3,0.2,0.2,0.2,0.3,1.9,5,18,56,420]
            default:
                print("error")
            }
        
        default:
            print("error")
        }
        
        
        return list
    }
}

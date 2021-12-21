//
//  PlinkoView.swift
//  Mines
//
//  Created by chase morgan on 12/20/21.
//

import SwiftUI
import UIKit


class PlinkoViewController: UIViewController {
        var states: StateVars = StateVars()
    
    
        let circleSize: CGFloat = 350.0
        var ballSize = 100
        var startingBalls = 3
        var payOut: Double = 100
        var animator: UIDynamicAnimator!
        var staticBalls: [UIView] = []
    
    func returnPayOut() -> Double{
        return payOut
    }
    func resetPayOut(){
        self.payOut = 0
    }
    func setStates(states: StateVars){
        self.states = states
    }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let boundary = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: view.frame.size.width,
                                                height: view.frame.size.height))
             boundary.layer.borderColor = UIColor.white.cgColor
            boundary.layer.borderWidth = 1.0
            
            view.addSubview(boundary)
            
            for rowNum in 0...Int(states.rows)-1{
                for ballNum in 0...startingBalls+rowNum-1{
                    if((startingBalls+1 + rowNum) % 2 == 0){
                        staticBalls.append(circleEven( circle_Width: Double(ballSize/Int(states.rows)), circle_Height: Double(ballSize/Int(states.rows)), postion_Width: view.frame.size.width, balls: Double(startingBalls+rowNum), ballNum: Double(ballNum), rows: Int(states.rows), rowNum: Double(rowNum), boundary: boundary))
                    }
                    else{
                        staticBalls.append(circleOdd( circle_Width: Double(ballSize/Int(states.rows)), circle_Height: Double(ballSize/Int(states.rows)), postion_Width: view.frame.size.width, balls: Double(startingBalls+rowNum), ballNum: Double(ballNum), rows: Int(states.rows), rowNum: Double(rowNum), boundary: boundary))
                        
                    }
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                   
                   
                   let gravity = UIGravityBehavior(items: staticBalls)
                   gravity.magnitude = 2.0
                   
                   let collision = UICollisionBehavior(items: staticBalls)
                   collision.collisionMode = .boundaries
                   collision.addBoundary(withIdentifier: "Boundary" as NSCopying,
                                         for: UIBezierPath.init(rect: boundary.bounds))
                   
                   let resistance = UIDynamicItemBehavior(items: staticBalls)
                   resistance.addItem(boundary)
                   resistance.elasticity = 0.5
                   
                   animator = UIDynamicAnimator(referenceView: boundary)
                   //animator.addBehavior(gravity)
                   animator.addBehavior(collision)
                   animator.addBehavior(resistance)
        }
    }

extension UIView {
    func setCornerRadius(_ amount: CGFloat) {
        self.layer.allowsEdgeAntialiasing = true
        self.layer.cornerRadius = amount
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

func circleEven(circle_Width: Double, circle_Height: Double, postion_Width: Double, balls: Double, ballNum: Double, rows: Int, rowNum: Double, boundary: UIView) -> UIView{
    
    let ball = UIView(frame: CGRect(x: (postion_Width * 0.5 - ((postion_Width/(Double(rows)+1.75)) * (balls)/2 - postion_Width/(Double(rows)+2) * 0.5)) + (postion_Width/(Double(rows)+2) * ballNum), y: postion_Width/(Double(rows)+1.5) * 2.0 + postion_Width/(Double(rows)+1.5) * rowNum, width: circle_Width,height: circle_Height))
    ball.backgroundColor = UIColor.white
    ball.setCornerRadius(circle_Width/2)
    boundary.addSubview(ball)
    
    
    return ball
    
}

func circleOdd(circle_Width: Double, circle_Height: Double, postion_Width: Double, balls: Double, ballNum: Double, rows: Int, rowNum: Double, boundary: UIView) -> UIView{
    
    let ball = UIView(frame: CGRect(x: (postion_Width * 0.5 - (postion_Width/(Double(rows)+1.75)) * (balls-1)/2) + (postion_Width/(Double(rows)+2) * ballNum), y: postion_Width/(Double(rows)+1.5) * 2.0 + postion_Width/(Double(rows)+1.5) * rowNum, width: circle_Width,height: circle_Height))
    ball.backgroundColor = UIColor.white
    ball.setCornerRadius(circle_Width/2)
    boundary.addSubview(ball)
    
    
    return ball
    
}






struct PlinkoView: UIViewControllerRepresentable{
    @ObservedObject var states: StateVars
    var exit: Bool
    var thisView = PlinkoViewController()
    func makeUIViewController(context: Context) -> UIViewController {
        thisView.setStates(states: states)
        return thisView
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if(exit){
            states.selected = 1
            states.bal += thisView.returnPayOut()
            thisView.resetPayOut()
            
        }
            
    }
    

    
    
    
    
    
   
    
    
    
    
    
    
    
    
}

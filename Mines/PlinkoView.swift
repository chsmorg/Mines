//
//  PlinkoView.swift
//  Mines
//
//  Created by chase morgan on 12/20/21.
//

import SwiftUI
import UIKit


class PlinkoViewController: UIViewController, UICollisionBehaviorDelegate {
        var states: StateVars = StateVars()
     
        let circleSize: CGFloat = 350.0
        var ballSize = 60
        var startingBalls = 3
        var payOut: Double = 100
        var animator: UIDynamicAnimator!
        var staticBalls: [UIView] = []
        var boundary: UIView = UIView()
        var ballsList: [UIView] = []
        var collision = UICollisionBehavior()
        var col = UIDynamicBehavior()
        var resistance = UIDynamicItemBehavior()
        let gravity = UIGravityBehavior()
        var attachment: UIAttachmentBehavior!
        var ballColor = UIColor.white
        
    

    let myFirstButton = UIButton()
    
    private func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
         print("Contact - \(identifier)")
    }
    
    func returnPayOut() -> Double{
        return payOut
    }
    func newBall(){
        
        let min = (boundary.frame.width * 0.5 - (boundary.frame.width/(Double(states.rows))*0.4))
        let max = (boundary.frame.width * 0.5 + (boundary.frame.width/(Double(states.rows))*0.2))
        
        let ran = Double.random(in: min...max)
        print(ran)
        
        let ball = PlinkoViewController.addBall(circle_Width: Double(160/Int(states.rows)), circle_Height: Double(160/Int(states.rows)), boundary: boundary, ran: ran, rows: Int(states.rows))
        collision.addItem(ball)
            gravity.addItem(ball)
            resistance.addItem(ball)
            ballsList.append(ball)
        
    }
    func resetPayOut(){
        self.payOut = 0
    }
    func fact(i: Double)-> Double{
        var j = i
        if(j>1){
            j *= fact(i: i-1)
        }
        return j
    }
    func biDis(placement: Int, rows: Int) -> Double{
        let k = Double(placement)
        let n = Double(rows)
        return (fact(i: n)) / (fact(i: k) * fact(i:(n-k)) * pow(2, n))
        
    }
    func setStates(states: StateVars){
        self.states = states
    }
        override func viewWillAppear(_ animated: Bool) {
            if (traitCollection.userInterfaceStyle == .light){
                ballColor = UIColor.black
            }
            
            super.viewWillAppear(animated)
            print(setMulti())
            print(fact(i: 4))
            
            
            boundary = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                            width: view.frame.size.width ,
                                                height: view.frame.size.height))
             boundary.layer.borderColor = UIColor.white.cgColor
            boundary.layer.borderWidth = 1.0
            
            view.addSubview(boundary)
            animator = UIDynamicAnimator(referenceView: boundary)
            
            for rowNum in 0...Int(states.rows)-1{
                for ballNum in 0...startingBalls+rowNum-1{
                    if((startingBalls+1 + rowNum) % 2 == 0){
                        let ball = circleEven( circle_Width: Double(ballSize/Int(states.rows)), circle_Height: Double(ballSize/Int(states.rows)), postion_Width: view.frame.size.width, balls: Double(startingBalls+rowNum), ballNum: Double(ballNum), rows: Int(states.rows), rowNum: Double(rowNum), boundary: boundary, ballColor: ballColor)
                        
                        let point = ball.center
                        attachment = UIAttachmentBehavior(item: ball, attachedToAnchor: point)
                        attachment.damping = 50
                        animator.addBehavior(attachment)
        
                        staticBalls.append(ball)
                    }
                    else{
                        let ball = circleOdd( circle_Width: Double(ballSize/Int(states.rows)), circle_Height: Double(ballSize/Int(states.rows)), postion_Width: view.frame.size.width, balls: Double(startingBalls+rowNum), ballNum: Double(ballNum), rows: Int(states.rows), rowNum: Double(rowNum), boundary: boundary, ballColor: ballColor)
                        let point = ball.center
                        attachment = UIAttachmentBehavior(item: ball, attachedToAnchor: point)
                        attachment.damping = 50
                        animator.addBehavior(attachment)
                        
                        staticBalls.append(ball)
                        
                    }
                }
            }
            
            
            
                myFirstButton.setTitle("✸", for: .normal)
                myFirstButton.setTitleColor(.blue, for: .normal)
                myFirstButton.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
                myFirstButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            boundary.addSubview(myFirstButton)
  
                   
            gravity.magnitude = 0.6
                   
            collision = UICollisionBehavior(items: staticBalls)
            collision.collisionMode = .boundaries
            collision.collisionDelegate=self
            //col.addChildBehavior(collision.collisionDelegate as! UIDynamicBehavior)
            
                    collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: boundary.frame))
            
            for i in 0...staticBalls.count-1{
                let num = String(i)
                
                collision.addBoundary(withIdentifier: num as NSCopying, for: UIBezierPath(ovalIn: staticBalls[i].frame))
            }
            

            
            

                   
                   resistance = UIDynamicItemBehavior(items: staticBalls)
                   resistance.addItem(boundary)
            resistance.elasticity = 0.2
                   
                   
                   animator.addBehavior(gravity)
                   animator.addBehavior(collision)
                   animator.addBehavior(resistance)
        }
    
    @objc func pressed() {
        newBall()
    }
    
    class func addBall(circle_Width: Double,circle_Height: Double, boundary:  UIView, ran: Double, rows: Int) -> UIView{
        
        print(ran)
        
        let ball = UIView(frame: CGRect(x: ran, y: boundary.frame.width/Double(rows)+1.5, width: circle_Width,height: circle_Height))
        ball.backgroundColor = UIColor.red
        ball.setCornerRadius(circle_Width/2)
        boundary.addSubview(ball)
        
        
        return ball
    }
    func setMulti() -> [Double]{
     
        var rowProp: [Double] = []
        let r = Int(states.rows)
        for i in 0...r{
            if(i==0 || i == r){
                rowProp.append(biDis(placement: 1, rows: r)/Double(r) * 100)
            }
            else{
                rowProp.append(biDis(placement: i, rows: r) * 100)
            }
            
        }
        return rowProp
        
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

func makeboxs(){
    
}

func circleEven(circle_Width: Double, circle_Height: Double, postion_Width: Double, balls: Double, ballNum: Double, rows: Int, rowNum: Double, boundary: UIView, ballColor: UIColor) -> UIView{
    let ball = UIView(frame: CGRect(x: (postion_Width * 0.5 - ((postion_Width/(Double(rows)+1.75)) * (balls)/2 - postion_Width/(Double(rows)+2) * 0.5)) + (postion_Width/(Double(rows)+2) * ballNum), y: postion_Width/(Double(rows)+1.5) * 2.0 + postion_Width/(Double(rows)+1.5) * rowNum, width: circle_Width,height: circle_Height))
    
    ball.backgroundColor = ballColor
    ball.setCornerRadius(circle_Width/2)
    
    boundary.addSubview(ball)
    
    
    
    
    return ball
    
}



func circleOdd(circle_Width: Double, circle_Height: Double, postion_Width: Double, balls: Double, ballNum: Double, rows: Int, rowNum: Double, boundary: UIView, ballColor: UIColor) -> UIView{
    
    let ball = UIView(frame: CGRect(x: (postion_Width * 0.5 - (postion_Width/(Double(rows)+1.75)) * (balls-1)/2) + (postion_Width/(Double(rows)+2) * ballNum), y: postion_Width/(Double(rows)+1.5) * 2.0 + postion_Width/(Double(rows)+1.5) * rowNum, width: circle_Width,height: circle_Height))
    ball.backgroundColor = ballColor
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
        //thisView.setStates(states: states)
        if(states.ballsToDrop > 0){
            thisView.newBall()
            print("dropped")
            states.ballsToDrop -= 1
        }
        if(exit){
            states.selected = 1
            states.bal += thisView.returnPayOut()
            thisView.resetPayOut()
            
        }
            
    }
    
    
    
    

    
    
    
    
    
   
    
    
    
    
    
    
    
    
}

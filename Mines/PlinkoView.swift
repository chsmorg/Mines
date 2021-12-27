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
        var boxProp: [Double] = []

        
    

    let myFirstButton = UIButton()
    
    
    
    func returnPayOut() -> Double{
        return payOut
    }
    func newBall(){
        var ran: Double
        
        let minL = (boundary.frame.width * 0.5 - (boundary.frame.width/(Double(states.rows))*0.9))
      let maxL = (boundary.frame.width * 0.5 - (boundary.frame.width/(Double(states.rows))*0.6))
        let minR = (boundary.frame.width * 0.5 + (boundary.frame.width/(Double(states.rows))*0.2))
        let maxR = (boundary.frame.width * 0.5 + (boundary.frame.width/(Double(states.rows))*0.4))
        
        let ranInt = Int.random(in: 1...2)
        
        if(ranInt==1){
            ran = Double.random(in: minL...maxL)
        }
        else{
            ran = Double.random(in: minR...maxR)
        }
        
        
        //print(ran)
        
        let ball = PlinkoViewController.addBall(circle_Width: Double(160/Int(states.rows)), circle_Height: Double(160/Int(states.rows)), boundary: boundary, ran: ran, rows: Int(states.rows))
            
            boundary.addSubview(ball)
        collision.addItem(ball)
            
            
            
        
       // print(collision.collisionDelegate as Any)
            
        
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
            boxProp = setMulti()
            
            
            
            
            boundary = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                            width: view.frame.size.width ,
                                                height: view.frame.size.height))
             //boundary.layer.borderColor = UIColor.white.cgColor
            //boundary.layer.borderWidth = 1.0
            
            view.addSubview(boundary)
            animator = UIDynamicAnimator(referenceView: boundary)
            
            for rowNum in 0...Int(states.rows)-1{
                for ballNum in 0...startingBalls+rowNum-1{
                    if((startingBalls + rowNum) % 2 == 0){
                        
                        
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
           makeBoxs()
            
            
            
                myFirstButton.setTitle("✸", for: .normal)
                myFirstButton.setTitleColor(.blue, for: .normal)
                myFirstButton.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
                myFirstButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            boundary.addSubview(myFirstButton)
  
                   
            gravity.magnitude = 0.5
                   
            //collision = UICollisionBehavior(items: ballsList)
            collision.collisionMode = .boundaries
            self.collision.collisionDelegate = self
            
            
            
                    collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: boundary.frame))
            
           for i in 0...staticBalls.count-1{
               let num = String(i)
                
               collision.addBoundary(withIdentifier: num as NSCopying, for: UIBezierPath(ovalIn: staticBalls[i].frame))
            }
            

            
            
                   // newBall()
           // collision.addItem(ballsList[0])
           // collision.collisionDelegate = self
                   
                   resistance = UIDynamicItemBehavior(items: staticBalls)
                   resistance.addItem(boundary)
            resistance.elasticity = 0.25
                   
                   
                   animator.addBehavior(gravity)
                   animator.addBehavior(collision)
                    
                   //colDetect.addChildBehavior(collision)
                   animator.addBehavior(resistance)
                   //animator.addBehavior(colDetect)
        }
    
    @objc func pressed() {
        newBall()
    }
    private func collisionBehavior(behavior: UICollisionBehavior!, beganContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        print("please")
    }
    
    class func addBall(circle_Width: Double,circle_Height: Double, boundary:  UIView, ran: Double, rows: Int) -> UIView{
        
       // print(ran)
    
        let ball = UIView(frame: CGRect(x: ran, y: boundary.frame.width/Double(rows)+1.5, width: circle_Width,height: circle_Height))
        ball.backgroundColor = UIColor.red
        ball.setCornerRadius(circle_Width/2)
        
        
        
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
    
    func makeBoxs() -> [UIView]{
    var boxList: [UIView] = []
        for i in 0...Int(states.rows){
            let box =  boxs(postion_Width: boundary.frame.width, boxSize: 160, boxs: Double(i), rows: Int(states.rows), boxProp: boxProp, circleWidth: Double(ballSize/Int(states.rows)))
            boundary.addSubview(box)
            boxList.append(box)
            
        }
        return boxList
        
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


func circleEven(circle_Width: Double, circle_Height: Double, postion_Width: Double, balls: Double, ballNum: Double, rows: Int, rowNum: Double, boundary: UIView, ballColor: UIColor) -> UIView{
    let postionWidthDisplacement = postion_Width
    let bpw = postionWidthDisplacement/(Double(rows)+2)
    let ballWidthDisplacment = postionWidthDisplacement/2 - ((bpw * (balls-2)/2) + (bpw * 0.5)) - circle_Width/2
                            
    let ball = UIView(frame: CGRect(x: ballWidthDisplacment + (bpw * ballNum), y:
    (bpw * 2.0) + (bpw * rowNum), width: circle_Width,height: circle_Height))
    
    ball.backgroundColor = ballColor
    ball.setCornerRadius(circle_Width/2)
    
    boundary.addSubview(ball)
    
    
    
    
    return ball
    
}



func circleOdd(circle_Width: Double, circle_Height: Double, postion_Width: Double, balls: Double, ballNum: Double, rows: Int, rowNum: Double, boundary: UIView, ballColor: UIColor) -> UIView{
    let postionWidthDisplacement = postion_Width
    let bpw = postionWidthDisplacement/(Double(rows)+2)
    let ballWidthDisplacment = postionWidthDisplacement/2 - (bpw * (balls-1)/2) - circle_Width/2
    
    let ball = UIView(frame: CGRect(x: ballWidthDisplacment + (bpw * ballNum), y:
    (bpw * 2.0) + (bpw * rowNum), width: circle_Width,height: circle_Height))
    
    
    ball.backgroundColor = ballColor
    ball.setCornerRadius(circle_Width/2)
    boundary.addSubview(ball)
    
    
    return ball
    
}

func boxs(postion_Width: Double, boxSize: Double, boxs: Double, rows: Int, boxProp: [Double], circleWidth: Double)-> UIView{
    var boxColor: UIColor
    let bpw = postion_Width/(Double(rows)+2)
    let boxWidthDisplacment = postion_Width/2 - (postion_Width/((Double(rows))+1.07)) * ((Double(rows))/2)
    
    
    if(boxProp[Int(boxs)] >= 15){
        boxColor = UIColor.yellow
        
    }
    else if (boxProp[Int(boxs)]<15 && boxProp[Int(boxs)]>=3){
        boxColor = UIColor.orange
    }
    else{
        boxColor = UIColor.red
    }
    let box = UIView(frame: CGRect(x: boxWidthDisplacment + bpw * boxs, y: bpw * 1.5 + bpw * Double(rows), width: boxSize/((Double(rows)+1.5)/2), height: boxSize/((Double(rows)+1.5)/2)))
    
    
    box.backgroundColor = boxColor
    box.setCornerRadius(50/Double(rows)+1.5)
    let label = UILabel(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    label.text = String(boxProp[Int(boxs)])
    box.addSubview(label)
                        
   
    
    return box
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
        thisView.setStates(states: states)
        if(states.ballsToDrop > 0){
            states.bal += thisView.returnPayOut()
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

//
//  CircleController.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import Foundation
import UIKit
import SwiftUI
import simd

class CircleController: UIViewController {
    
    var position: simd_float2
    var size: CGSize
    var directionAngle: CGFloat = 3 * .pi / 2
    var distance: CGFloat = 0
    
    
    var line = CAShapeLayer()
    var lineL = CAShapeLayer()
    var lineR = CAShapeLayer()

    var circle: UIView
    var smallCircle: UIView
    var smallCircleL: UIView
    var smallCircleR: UIView
    
    var joystick: JoystickView
      
    
    init(position: simd_float2, size: CGSize, joystick: JoystickView) {
        self.position = position
        self.size = size
        self.distance = size.width
        self.joystick = joystick
        
        self.circle = UIHostingController(rootView: CircleView()).view
        self.smallCircle = UIHostingController(rootView: CircleView()).view
        self.smallCircleL = UIHostingController(rootView: CircleView()).view
        self.smallCircleR = UIHostingController(rootView: CircleView()).view
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewCode()
    }
    
  
    
    func update(_ deltaTime: TimeInterval) {
        drawline()
        
        if joystick.direction.angle() != 0{
            self.directionAngle = joystick.direction.angle()
        }
        
        self.position.x += joystick.direction.x
        self.position.y += -joystick.direction.y
        circle.layer.position = self.position.toCgPoint()
        
    }
    
    func drawline(){
        //constant of angle 45
        let angle45: CGFloat = .pi / 4
        
        //initiating the path
        let path = UIBezierPath()
        let pathL = UIBezierPath()
        let pathR = UIBezierPath()
        
        //initiating the line
        path.move(to: position.toCgPoint())
        pathL.move(to: position.toCgPoint())
        pathR.move(to: position.toCgPoint())
        
        //calculating the end x and y to know the end of the line
        let endX = position.toCgPoint().x + distance * cos(directionAngle)
        let endY = position.toCgPoint().y + distance * sin(directionAngle)
        
        let endXL = position.toCgPoint().x + distance * cos(directionAngle + angle45)
        let endYL = position.toCgPoint().y + distance * sin(directionAngle + angle45)
        
        let endXR = position.toCgPoint().x + distance * cos(directionAngle - angle45)
        let endYR = position.toCgPoint().y + distance * sin(directionAngle - angle45)
        
        path.addLine(to: CGPoint(x: endX, y: endY))
        pathL.addLine(to: CGPoint(x: endXL, y: endYL))
        pathR.addLine(to: CGPoint(x: endXR, y: endYR))

        //setting path
        line.path = path.cgPath
        line.strokeColor = UIColor.blue.cgColor
        line.lineWidth = 10
        
        lineL.path = pathL.cgPath
        lineL.strokeColor = UIColor.blue.cgColor
        
        lineR.path = pathR.cgPath
        lineR.strokeColor = UIColor.blue.cgColor
        
        
        smallCircle.layer.position = CGPoint(x: endX, y: endY)
        smallCircleL.layer.position = CGPoint(x: endXL, y: endYL)
        smallCircleR.layer.position = CGPoint(x: endXR, y: endYR)
    }
}

extension CircleController: ViewCode{
    func addViews() {
        addListSubviews(circle, smallCircle, smallCircleL, smallCircleR)
//        addListSubviews(line, lineL, lineR)
    }
    
    func addConstraints() {
        
    }
    
    func setupStyle() {
        circle.frame = CGRect(origin: position.toCgPoint(), size: size)
        circle.layer.cornerRadius = size.width / 2
        
        let sSize = CGSize(width: 40, height: 40)
        smallCircle.frame = CGRect(origin: .zero, size: sSize)
        smallCircle.layer.cornerRadius = size.width / 2
        
        smallCircleL.frame = CGRect(origin: .zero, size: sSize)
        smallCircleL.layer.cornerRadius = size.width / 2
        
        smallCircleR.frame = CGRect(origin: .zero, size: sSize)
        smallCircleR.layer.cornerRadius = size.width / 2
    }
}

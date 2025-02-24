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

class HeadSnakeController: UIViewController {
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
    
    var controllerJoystick: simd_float2
    
    var body: BodyView?
      
    
    init(position: simd_float2, size: CGSize, joystick: simd_float2) {
        self.position = position
        self.size = size
        self.distance = size.width
        self.controllerJoystick = joystick
        
        self.circle = UIView()
        self.smallCircle = UIView()
        self.smallCircleL = UIView()
        self.smallCircleR = UIView()
        
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
        
        if controllerJoystick.angle() != 0{
            self.directionAngle = controllerJoystick.angle()
        }
        
        self.position.x += controllerJoystick.x
        self.position.y += -controllerJoystick.y
        circle.layer.position = self.position.toCgPoint()
        
    }
    
    func drawline(){
        //constant of angle 45
        let angle45: CGFloat = .pi / 4
        
//        //initiating the path
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
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 5
        
        lineL.path = pathL.cgPath
        lineL.strokeColor = UIColor.red.cgColor
        
        lineR.path = pathR.cgPath
        lineR.strokeColor = UIColor.red.cgColor
        
        
        smallCircle.layer.position = CGPoint(x: endX, y: endY)
        smallCircleL.layer.position = CGPoint(x: endXL, y: endYL)
        smallCircleR.layer.position = CGPoint(x: endXR, y: endYR)
    }
}

extension HeadSnakeController: ViewCode{
    func addViews() {
        
        view.layer.addSublayer(line)
        view.layer.addSublayer(lineL)
        view.layer.addSublayer(lineR)
        
        addListSubviews(circle, smallCircle, smallCircleL, smallCircleR)
        
    }
    
    func addConstraints() {
        
    }
    
    func setupStyle() {
        circle.frame = CGRect(origin: position.toCgPoint(), size: size)
        circle.layer.cornerRadius = size.width / 2
        circle.backgroundColor = .red
        
        let sSize = CGSize(width: 50, height: 50)
        smallCircle.frame = CGRect(origin: .zero, size: sSize)
        smallCircle.layer.cornerRadius = size.width / 2
        smallCircle.backgroundColor = .red
        
        smallCircleL.frame = CGRect(origin: .zero, size: sSize)
        smallCircleL.layer.cornerRadius = size.width / 2
        smallCircleL.backgroundColor = .red
        
        smallCircleR.frame = CGRect(origin: .zero, size: sSize)
        smallCircleR.layer.cornerRadius = size.width / 2
        smallCircleR.backgroundColor = .red
    }
}

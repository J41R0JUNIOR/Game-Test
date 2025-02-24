//
//  ViewController.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, Updateable {
    
    
    var timerToUpdate: Timer?
    var deltaTime: TimeInterval = 1/60
    var circle: CircleController?
    var joystick: JoystickView?
    
    var countToUpdateAngle: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = CGSize(width: 100, height: 100)
        let position = CGPoint(x: (view.frame.width - size.width) / 2, y: (view.frame.height - size.height) / 2)
        
        circle = CircleController(position: position, size: size)
        circle?.view.layer.borderColor = UIColor.blue.cgColor
        circle?.view.layer.borderWidth = 2
        
        joystick = JoystickView(size: CGSize(width: 120, height: 120))
        
        setupViewCode()
        
        startUpdateLoop(deltaTime: deltaTime)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        guard let circleView = circle?.view else { return }
        
        let position = touch.location(in: view)
        let previous = touch.precisePreviousLocation(in: view)
        
        if circleView.frame.contains(position) {
            
            let deltaY = position.y - previous.y
            let deltaX = position.x - previous.x
            
            let newAngle = atan2(deltaY, deltaX)
            
            circle?.newPosition = position
            circle?.directionAngle = newAngle
            
        }
    }
    
}

extension ViewController: ViewCode {
    
    func addViews() {
        if let circle = circle {
            view.addSubview(circle.view)
        }
        
        if let joystick = joystick {
//            addChild(joystick)
            view.addSubview(joystick.view)
//            joystick.didMove(toParent: self)
        }
    }
    
    func addConstraints() {
        
        if let joystick = joystick{
            joystick.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                joystick.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                joystick.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                joystick.view.widthAnchor.constraint(equalToConstant: 120), // Definindo largura
                joystick.view.heightAnchor.constraint(equalToConstant: 120) // Definindo altura
            ])
        }
    }
    
    func setupStyle() {
        
    }
    
    func update(_ deltaTime: TimeInterval) {
        circle?.update(deltaTime)
    }
}

//
//  Joystick.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import UIKit
import SwiftUI
import simd

class JoystickView: UIViewController, Updateable, ViewCode {
    
    var timerToUpdate: Timer?
    var deltaTime: TimeInterval = 1/60
    
    var background: UIView
    var button: UIView
    
    var size: CGSize
    var position: CGPoint
    
    var direction: simd_float2 = .zero

    
    init(size: CGSize){
        self.background = UIView()
        self.button = UIView()
        self.size = size
        self.position = .zero
        
        super.init(nibName: nil, bundle: nil)
        
        setupViewCode()
        startUpdateLoop(deltaTime: deltaTime)
    }
    
    override func viewDidLoad() {
        self.position = CGPoint(x: view.frame.origin.x + size.width * 0.5 , y: view.frame.origin.y + size.height * 0.5)
//        self.position = background.center
     
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: view)
        
        let dx = position.x - background.layer.position.x
        let dy = -(position.y - background.layer.position.y)
        let maxDistance = size.width * 0.5
        let distance = sqrt(dx * dx + dy * dy)
        
        if distance < maxDistance {
            self.position = position
            
        } else {
            let angle = atan2(dy, dx)
            self.position = CGPoint(
                x: background.layer.position.x + cos(angle) * maxDistance,
                y: background.layer.position.y - sin(angle) * maxDistance
            )
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.position = background.layer.position
        
    }
    
    func addViews() {
        view.addSubview(background)
        view.addSubview(button)
        
        background.layer.borderColor = UIColor.white.cgColor
        background.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            background.widthAnchor.constraint(equalToConstant: size.width),
            background.heightAnchor.constraint(equalToConstant: size.height),
            
          
            button.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalTo: background.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func setupStyle() {
        background.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        background.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        button.backgroundColor = .blue
        
        background.layer.cornerRadius = size.width / 2
        button.layer.cornerRadius = size.width / 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ deltaTime: TimeInterval) {
        button.layer.position = position
        
        let maxDistance = size.width * 0.5
        let dx = position.x - background.layer.position.x
        let dy = -(position.y - background.layer.position.y)
        direction = simd_float2(Float(dx / maxDistance), Float(dy / maxDistance))
    }
}

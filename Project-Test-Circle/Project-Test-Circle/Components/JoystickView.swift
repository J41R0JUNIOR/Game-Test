//
//  Joystick.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import UIKit
import SwiftUI

class JoystickView: UIViewController, Updateable, ViewCode {
    
    var timerToUpdate: Timer?
    var deltaTime: TimeInterval = 1/60
    
    var background: UIView
    var button: UIView

    init(size: CGSize){
        self.background = UIView()
        self.button = UIView()
        
        super.init(nibName: nil, bundle: nil)
        
        setupViewCode()
    }
    
  
    
    func addViews() {
        view.addSubview(background)
        background.addSubview(button)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            background.widthAnchor.constraint(equalToConstant: 120),
            background.heightAnchor.constraint(equalToConstant: 120),
            
//            button.centerXAnchor.constraint(equalTo: background.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: background.centerYAnchor),
//            button.widthAnchor.constraint(equalToConstant: 40),
//            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        button.layer.position = background.layer.position
    }
    
    func setupStyle() {
        background.backgroundColor = .gray.withAlphaComponent(0.5)
        button.backgroundColor = .blue
        background.layer.cornerRadius = 60
        button.layer.cornerRadius = 20
        
        background.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ deltaTime: TimeInterval) {
        
    }
}

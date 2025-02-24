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
    
    var countToUpdateAngle: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = CGSize(width: 100, height: 100)
        let position = CGPoint(x: (view.frame.width - size.width) / 2, y: (view.frame.height - size.height) / 2)
        circle = CircleController(position: position, size: size)

        
        setupViewCode()
        
        startUpdateLoop(deltaTime: deltaTime)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: view)
        let previus = touch.precisePreviousLocation(in: view)
        
        countToUpdateAngle += 1
        
        let deltaY = position.y - previus.y
        let deltaX = position.x - previus.x
        
        let newAngle = atan2(deltaY, deltaX)
        
        circle?.newPosition = position
        
        if countToUpdateAngle > 2{
            countToUpdateAngle = 0
            circle?.directionAngle = newAngle
        }
    }
}

extension ViewController: ViewCode {
    
    func addViews() {
        if let circle = circle {
            view.addSubview(circle.view)
        }
    }
    
    func addConstraints() {
        
    }
    
    func setupStyle() {
        
    }
    
    func update(_ deltaTime: TimeInterval) {
        circle?.update(deltaTime)
    }
}

//
//  ViewController.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import UIKit
import SwiftUI
import MetalKit

class ViewController: UIViewController, Updateable {
 
    var timerToUpdate: Timer?
    var deltaTime: TimeInterval = 1/30
    var circle: HeadSnakeController?
    var joystick: JoystickView?
    
    var countToUpdateAngle: Int = 0
    
    var device: MTLDevice!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.device = MTLCreateSystemDefaultDevice()!
        
        let metalView = MTKView(frame: self.view.bounds, device: device)
        metalView.delegate = self
//        view = metalView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        setupViewCode()
        
        startUpdateLoop(deltaTime: deltaTime)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        guard let circleView = circle?.circle else { return }
        
        let position = touch.location(in: view)
        let previous = touch.precisePreviousLocation(in: view)
        
        if circleView.frame.contains(position) {

            let deltaY = position.y - previous.y
            let deltaX = position.x - previous.x

            let newAngle = atan2(deltaY, deltaX)

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
            view.addSubview(joystick.view)
        }
    }
    
    func addConstraints() {
        
        if let joystick = joystick{
            joystick.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                joystick.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                joystick.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                joystick.view.widthAnchor.constraint(equalToConstant: joystick.size.width),
                joystick.view.heightAnchor.constraint(equalToConstant: joystick.size.height)
            ])
        }
    }
    
    func setupStyle() {
        let size = CGSize(width: 50, height: 50)
        let position = CGPoint(x: (view.frame.width - size.width) / 2, y: (view.frame.height - size.height) / 2).toSimdFloat2()
        
        joystick = JoystickView(size: CGSize(width: 100, height: 100))
   
        if let joystick = joystick{
            circle = HeadSnakeController(position: position, size: size, joystick: joystick.direction)
        }
    }
    
    func update(_ deltaTime: TimeInterval) {
        
        circle?.update(deltaTime)
        circle?.controllerJoystick = joystick?.direction ?? .zero
    }
}

extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        
    }
}

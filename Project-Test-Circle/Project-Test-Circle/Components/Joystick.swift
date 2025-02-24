//
//  Joystick.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import UIKit
import SwiftUI

class Joystick: UIViewController, Updateable, ViewCode {
    
    
    var timerToUpdate: Timer?
    var deltaTime: TimeInterval = 1/60
    
    var background: UIView
    var button: UIView
    
    init(){
        self.background = UIHostingController(rootView: CircleView()).view
        self.button = UIHostingController(rootView: CircleView()).view
        
   
        button.frame.size = CGSize(width: 40, height: 40)
        background.frame.size = CGSize(width: 100, height: 10)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    func addViews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func setupStyle() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ deltaTime: TimeInterval) {
        
    }
    
    
}

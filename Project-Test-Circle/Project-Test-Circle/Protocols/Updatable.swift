//
//  Updatable.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import Foundation
import UIKit

protocol Updateable: UIViewController {
    var timerToUpdate: Timer? { get set }
    var deltaTime: TimeInterval { get set }
    
    func update(_ deltaTime: TimeInterval)
}

extension Updateable {
    func startUpdateLoop(deltaTime: TimeInterval) {
        timerToUpdate = Timer.scheduledTimer(withTimeInterval: deltaTime, repeats: true) { [ weak self ] time in
            self?.update(time.timeInterval)
        }
    }
    
    func stopUpdateLoop() {
        timerToUpdate?.invalidate()
    }
}

//
//  Routes.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//

import Foundation
import UIKit
import SwiftUI

enum Destination {
    case main
}

class Routes {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigate(to: .main, .push)
    }
    
    enum TypeTransition: String {
        case push = "fromRight"
        case pop = "fromLeft"
    }
    
    func navigate(to destination: Destination, _ type: TypeTransition = .push) {
        navigationController.viewControllers.removeAll()
        
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = CATransitionSubtype(rawValue: type.rawValue)
        
        navigationController.view.layer.add(transition, forKey: nil)
        
        switch destination {
       
        case .main:
            let view = createMainModule()
            navigationController.pushViewController(view, animated: true)
        }
    }
    
  
    func createMainModule() -> UIViewController {
       
//        let viewController = UIHostingController(rootView: CircleView().navigationBarBackButtonHidden())
        let viewController = ViewController()
        return viewController
    }
}


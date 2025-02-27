//
//  ViewCode.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 23/02/25.
//


import UIKit

// Extension that allows adding multiple views to the hierarchy in a single call. Example: addViews(label1, label2, button1, button2)
extension UIViewController {
    func addListSubviews(_ views: UIView...) {
        for view in views {
            self.view.addSubview(view)
        }
    }
}

protocol ViewCode {
    // Adds views as subviews and defines the hierarchy between them
    func addViews()
    
    // Defines the constraints to be used for positioning the elements in the view
    func addConstraints()
    
    // Defines the styles for the view, such as color, borders, etc.
    func setupStyle()
}


// Chama todos os métodos do protocolo
extension ViewCode {
    func setupViewCode() {
        setupStyle()
        addViews()
        addConstraints()
    }
}

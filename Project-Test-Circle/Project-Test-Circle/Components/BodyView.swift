//
//  BodyView.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 24/02/25.
//

import UIKit

class BodyView: UIView {
    var prev: BodyView?
    var nex: BodyView?
    
    init(prev: BodyView? = nil, nex: BodyView? = nil, frame: CGRect) {
        self.prev = prev
        self.nex = nex
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

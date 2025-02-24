//
//  Simd3.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 24/02/25.
//

import Foundation
import simd

extension simd_float2 {
    func toCgPoint() -> CGPoint {
        return CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))
    }
    
    func angle() -> CGFloat {
        return CGFloat(atan2(-self.y, self.x))
    }
}

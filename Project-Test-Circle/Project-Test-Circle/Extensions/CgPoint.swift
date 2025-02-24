//
//  CgPoint.swift
//  Project-Test-Circle
//
//  Created by The Godfather Júnior on 24/02/25.
//

import Foundation

extension CGPoint{
    func toSimdFloat2() -> SIMD2<Float>{
        return SIMD2<Float>(x: Float(self.x), y: Float(self.y))
    }
}

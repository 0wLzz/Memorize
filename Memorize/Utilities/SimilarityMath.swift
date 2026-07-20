//
//  SimilarityMath.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/07/26.
//  Pure math helper — no I/O, no framework dependency, safe for reuse
//  by the Share Extension target.
//

import Foundation

enum SimilarityMath {
    static func cosineSimilarity(_ a: [Float], _ b: [Float]) -> Float {
        let dot = zip(a, b).map(*).reduce(0, +)
        let normA = sqrt(a.map { $0 * $0 }.reduce(0, +))
        let normB = sqrt(b.map { $0 * $0 }.reduce(0, +))
        return dot / (normA * normB)
    }
}

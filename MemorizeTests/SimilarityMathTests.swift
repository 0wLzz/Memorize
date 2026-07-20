//
//  SimilarityMathTests.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/07/26.

import XCTest
@testable import Memorize

final class SimilarityMathTests: XCTestCase {

    func testCosineSimilarity_identicalVectors_returnsOne() {
        let a: [Float] = [1, 0, 0]
        XCTAssertEqual(SimilarityMath.cosineSimilarity(a, a), 1.0, accuracy: 0.0001)
    }

    func testCosineSimilarity_orthogonalVectors_returnsZero() {
        let a: [Float] = [1, 0, 0]
        let b: [Float] = [0, 1, 0]
        XCTAssertEqual(SimilarityMath.cosineSimilarity(a, b), 0.0, accuracy: 0.0001)
    }

    func testCosineSimilarity_oppositeVectors_returnsNegativeOne() {
        let a: [Float] = [1, 0, 0]
        let b: [Float] = [-1, 0, 0]
        XCTAssertEqual(SimilarityMath.cosineSimilarity(a, b), -1.0, accuracy: 0.0001)
    }
}

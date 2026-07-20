//
//  FakeFaceRecognitionService.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/07/26.
//
import UIKit
@testable import Memorize

// Test target only
final class FakeFaceRecognitionService: FaceRecognitionServicing {
    var stubbedEmbedding: [Float]?

    func generateEmbedding(from image: UIImage) async -> [Float]? {
        return stubbedEmbedding
    }
}

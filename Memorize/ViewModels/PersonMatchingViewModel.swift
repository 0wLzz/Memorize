//
//  PersonMatchingViewModel.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/07/26.
//
import Foundation

@Observable
final class PersonMatchingViewModel {
    private let personRepository: PersonRepositoryProtocol
    private let faceRecognitionService: FaceRecognitionServicing

    var matchResult: PersonModel? = nil
    var matchScore: Float? = nil
    var isMatching: Bool = false
    var errorMessage: String? = nil

    init(
        personRepository: PersonRepositoryProtocol,
        faceRecognitionService: FaceRecognitionServicing
    ) {
        self.personRepository = personRepository
        self.faceRecognitionService = faceRecognitionService
    }
}

extension PersonMatchingViewModel {

    /// Compares the given embedding against all People that have a stored
    /// faceEmbedding, returning the closest match and its similarity score.
    /// People without a faceEmbedding yet are skipped.
    func findBestMatch(
        for embedding: [Float],
        among people: [PersonModel]
    ) -> (person: PersonModel?, score: Float) {
        var bestPerson: PersonModel? = nil
        var bestScore: Float = -1.0 // cosine similarity range is -1...1

        for person in people {
            guard let storedEmbedding = person.faceEmbedding else { continue }
            let score = SimilarityMath.cosineSimilarity(embedding, storedEmbedding)
            if score > bestScore {
                bestScore = score
                bestPerson = person
            }
        }

        return (bestPerson, bestScore)
    }
}

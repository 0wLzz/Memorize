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

extension PersonMatchingViewModel {

    /// Below this cosine similarity, a match is not considered confident
    /// enough to call "known." Tune based on real test data over time.
    static let matchThreshold: Float = 0.7

    /// Runs the full match pipeline for a given embedding against known People,
    /// and updates published state for the View to observe.
    func evaluateMatch(for embedding: [Float], among people: [PersonModel]) {
        let result = findBestMatch(for: embedding, among: people)

        if result.score >= Self.matchThreshold {
            matchResult = result.person
            matchScore = result.score
        } else {
            matchResult = nil
            matchScore = result.score
        }
    }
}

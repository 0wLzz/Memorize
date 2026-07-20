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

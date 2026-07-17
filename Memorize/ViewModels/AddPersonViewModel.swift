//
//  AddPersonViewModel.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 17/07/26.
//

import Foundation
import UIKit
@Observable
final class AddPersonViewModel {
    private let photoLibraryService: PhotoLibraryServicing
    private let personRepository: PersonRepositoryProtocol

    var availableAssetIdentifiers: [String] = []
    var resolvedImage: UIImage? = nil
    var errorMessage: String? = nil

    init(photoLibraryService: PhotoLibraryServicing, personRepository: PersonRepositoryProtocol) {
        self.photoLibraryService = photoLibraryService
        self.personRepository = personRepository
    }
}

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
    
    func loadAssetIdentifiers() {
        availableAssetIdentifiers = photoLibraryService.fetchAllAssetIdentifiers()
    }
    
    func resolveImage(for identifier: String) async {
        resolvedImage = await photoLibraryService.resolveImage(for: identifier, targetSize: CGSize(width: 300, height: 300))
    }
    
    func tagAsset(_ identifier: String, to person: PersonModel) {
        var updatedPerson = person
        updatedPerson.linkedAssetIdentifiers.append(identifier)
        personRepository.update(updatedPerson)
    }
}

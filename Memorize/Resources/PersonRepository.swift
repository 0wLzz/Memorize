//
//  PhotoRepository.swift
//  Memorize
//
//  Created by Owen Limantoro on 22/04/26.
//

import Foundation
import SwiftData
import Combine

final class PersonRepository: ObservableObject {
    @Published var persons: [PersonModel] = []
    @Published var interests: [InterestModel] = InterestModel.interests

    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchPersons()
    }

    func fetchPersons() {
        let descriptor = FetchDescriptor<PersonModel>()
        persons = (try? context.fetch(descriptor)) ?? []
    }

    func insert(_ person: PersonModel) {
        context.insert(person)
        fetchPersons()
    }

    func delete(_ person: PersonModel) {
        context.delete(person)
        fetchPersons()
    }
}

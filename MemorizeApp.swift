//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI
import SwiftData

@main
struct MemorizeApp: App {
    let container = try! ModelContainer(for: PersonModel.self)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PersonRepository(context: container.mainContext))
        }
        .modelContainer(container)
    }
}

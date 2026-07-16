//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//
// COMMENTED BLOCK OF CODE IS THE OLD VERSION
//import SwiftUI
//
//@main
//struct MemorizeApp: App {
//    @StateObject private var repo = PersonRepository()
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environmentObject(repo)
//        }
//    }
//}

import SwiftUI
import SwiftData

@main
struct MemorizeApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: PersonEntity.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            Text("Repository rebuild in progress")
        }
        .modelContainer(container)
    }
}

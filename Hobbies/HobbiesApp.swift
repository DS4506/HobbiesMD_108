//
//  HobbiesApp.swift
//  Hobbies
//
//  Created by Willie Earl on 9/15/25.
//

//
//  HobbiesApp.swift
//  Hobbies
//

import SwiftUI

@main
struct HobbiesApp: App {
    private let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ProfileScreen()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}

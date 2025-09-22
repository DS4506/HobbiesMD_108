//
//  ProfileHobbies.swift
//  Hobbies
//
//  Created by Willie Earl on 9/15/25.
//

import SwiftUI

@main
struct HobbiesApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ProfileAndHobbiesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

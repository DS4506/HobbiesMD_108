//
//  ExportImport.swift
//  Hobbies
//
//  Created by Willie Earl on 9/15/25.
//

import Foundation
import CoreData

// Build a backup blob from current state
public func buildBackupData(ctx: NSManagedObjectContext,
                            name: String,
                            occupation: String,
                            email: String) throws -> Data {
    let profile = ProfileDTO(name: name, occupation: occupation, email: email)
    let hobbies = try fetchAllHobbies(ctx).map { HobbyDTO(name: $0.name!, createdAt: $0.createdAt!) }
    let backup = BackupDTO(schemaVersion: 1, profile: profile, hobbies: hobbies)
    let enc = JSONEncoder()
    enc.outputFormatting = [.prettyPrinted]
    return try enc.encode(backup)
}
// Import backup from URL and apply to UserDefaults + Core Data
public func importBackup(from url: URL,
                         into ctx: NSManagedObjectContext,
                         replaceHobbies: Bool,
                         setProfile: (ProfileDTO) -> Void) throws {
    let data = try Data(contentsOf: url)
    let backup = try JSONDecoder().decode(BackupDTO.self, from: data)
    // Apply profile via closure so caller can update @AppStorage
    setProfile(backup.profile)
    // Apply hobbies
    if replaceHobbies {
        try deleteAllHobbies(in: ctx)
    }
    for h in backup.hobbies {
        let obj = Hobby(context: ctx)
        obj.name = h.name
        obj.createdAt = h.createdAt
    }
    try ctx.save()
}
// MARK: - Core Data helpers for Hobby
public func fetchAllHobbies(_ ctx: NSManagedObjectContext) throws -> [Hobby] {
    let req: NSFetchRequest<Hobby> = Hobby.fetchRequest()
    req.sortDescriptors = [NSSortDescriptor(keyPath: \Hobby.createdAt, ascending: false)]
    return try ctx.fetch(req)
}

public func deleteAllHobbies(in ctx: NSManagedObjectContext) throws {
    let f: NSFetchRequest<NSFetchRequestResult> = Hobby.fetchRequest()
    let d = NSBatchDeleteRequest(fetchRequest: f)
    try ctx.execute(d)
    try ctx.save()
}

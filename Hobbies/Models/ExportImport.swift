//
//  ExportImport.swift
//  Hobbies
//
//  Created by Willie Earl on 9/15/25.
//

ExportImport.swift
import Foundation

public struct ProfileDTO: Codable, Hashable {
    public var name: String
    public var occupation: String
    public var email: String
}

public struct HobbyDTO: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var name: String
    public var createdAt: Date
}

public struct BackupDTO: Codable, Hashable {
    public var schemaVersion: Int
    public var profile: ProfileDTO
    public var hobbies: [HobbyDTO]
}

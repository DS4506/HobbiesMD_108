//
//  JSONFile.swift
//  Hobbies
//
//  Created by Willie Earl on 9/15/25.
//

//
//  JSONFile.swift
//  Hobbies
//

import SwiftUI
import UniformTypeIdentifiers

public struct JSONFile: FileDocument {
    public static var readableContentTypes: [UTType] = [.json]
    public var data: Data

    public init(data: Data) { self.data = data }

    public init(configuration: ReadConfiguration) throws {
        guard let d = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.data = d
    }

    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return .init(regularFileWithContents: data)
    }
}

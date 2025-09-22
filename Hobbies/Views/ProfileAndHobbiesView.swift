//
//  ProfileAndHobbiesView.swift
//  Hobbies
//
//  Created by Willie Earl on 9/15/25.
//

import SwiftUI

struct ProfileView: View {
    // Persistent storage
    @AppStorage("profile.name") private var storedName: String = ""
    @AppStorage("profile.occupation") private var storedOccupation: String = ""
    @AppStorage("profile.email") private var storedEmail: String = ""

    // Editing state
    @State private var name: String = ""
    @State private var occupation: String = ""
    @State private var email: String = ""
    @State private var emailIsValid: Bool = true

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .textContentType(.name)
                TextField("Occupation", text: $occupation)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                if !emailIsValid {
                    Text("Enter a valid email address")
                        .foregroundStyle(.red)
                        .font(.footnote)

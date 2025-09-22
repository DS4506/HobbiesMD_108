//
//  ProfileScreen.swift
//  Hobbies
//
//  Created by Willie Earl on 9/22/25.
//

//
//  ProfileScreen.swift
//  Hobbies
//

import SwiftUI
import CoreData

struct ProfileScreen: View {
    @Environment(\.managedObjectContext) private var ctx
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.createdAt, ascending: false)],
        animation: .default
    ) private var hobbies: FetchedResults<Hobby>

    @State private var name: String = "John Doe"
    @State private var occupation: String = "Software Engineer"
    @State private var email: String = "john.doe@example.com"
    @State private var newHobby: String = ""

    private var emailIsValid: Bool { email.isEmpty || email.contains("@") }

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.shellGradient.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {

                        // Title
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Profile Management")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundStyle(AppTheme.textPrimary)
                            Text("Edit details and manage hobbies")
                                .foregroundStyle(AppTheme.textSecondary)
                        }
                        .padding(.top, 8)

                        // Profile card
                        VStack(alignment: .leading, spacing: 12) {
                            LabeledField(title: "Name", text: $name, sf: "person.fill")
                            LabeledField(title: "Occupation", text: $occupation, sf: "briefcase.fill")
                            VStack(alignment: .leading, spacing: 8) {
                                LabeledField(title: "Email", text: $email, sf: "envelope.fill",
                                             keyboard: .emailAddress, noCap: true)
                                if !emailIsValid {
                                    Text("Enter a valid email address")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                        }
                        .cardContainer()

                        // Hobbies card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "sparkles")
                                    .foregroundStyle(AppTheme.accent)
                                Text("Hobbies")
                                    .font(.headline)
                                Spacer()
                            }

                            // Styled list
                            List {
                                ForEach(hobbies) { hobby in
                                    HStack(spacing: 10) {
                                        Circle()
                                            .fill(AppTheme.accent.opacity(0.20))
                                            .frame(width: 28, height: 28)
                                            .overlay(
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundStyle(AppTheme.accent)
                                            )
                                        Text(hobby.name ?? "(Untitled)")
                                            .font(.body)
                                        Spacer(minLength: 0)
                                    }
                                    .listRowBackground(Color.clear)
                                }
                                .onDelete(perform: deleteHobbies)
                            }
                            .frame(height: min(CGFloat(hobbies.count) * 58 + 60, 250))
                            .scrollContentBackground(.hidden)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.thinMaterial)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .listStyle(.plain)

                            HStack(spacing: 12) {
                                TextField("Enter new hobby", text: $newHobby)
                                    .filledField()
                                Button {
                                    addHobby()
                                } label: {
                                    Label("Add Hobby", systemImage: "plus.circle.fill")
                                }
                                .buttonStyle(SecondaryButtonStyle())
                            }
                        }
                        .cardContainer()

                        // Summary button
                        NavigationLink {
                            ProfileSummaryView(
                                name: name,
                                occupation: occupation,
                                email: email,
                                hobbies: hobbies.map { $0.name ?? "" }.filter { !$0.isEmpty }
                            )
                        } label: {
                            Text("View Summary")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .padding(.top, 6)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 28)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Actions

    private func addHobby() {
        let trimmed = newHobby.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let h = Hobby(context: ctx)
        h.name = trimmed
        h.createdAt = Date()
        do {
            try ctx.save()
            newHobby = ""
        } catch {
            assertionFailure("Failed to save hobby: \(error)")
        }
    }

    private func deleteHobbies(at offsets: IndexSet) {
        for index in offsets {
            ctx.delete(hobbies[index])
        }
        do { try ctx.save() } catch {
            assertionFailure("Failed to delete hobby: \(error)")
        }
    }
}

// MARK: - Small helper view

private struct LabeledField: View {
    let title: String
    @Binding var text: String
    var sf: String = "square.and.pencil"
    var keyboard: UIKeyboardType = .default
    var noCap: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: sf).foregroundStyle(AppTheme.accent)
                Text("\(title):").font(.subheadline).bold()
            }
            TextField("Enter \(title.lowercased())", text: $text)
                .keyboardType(keyboard)
                .textContentType(keyboard == .emailAddress ? .emailAddress : nil)
                .autocorrectionDisabled(noCap)
                .textInputAutocapitalization(noCap ? .never : .sentences)
                .filledField()
        }
    }
}

#Preview {
    let pc = PersistenceController.shared
    return ProfileScreen()
        .environment(\.managedObjectContext, pc.container.viewContext)
}

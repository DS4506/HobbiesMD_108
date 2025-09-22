//
//  ProfileSummaryView.swift
//  Hobbies
//
//  Created by Willie Earl on 9/22/25.
//

//
//  ProfileSummaryView.swift
//  Hobbies
//

import SwiftUI

struct ProfileSummaryView: View {
    let name: String
    let occupation: String
    let email: String
    let hobbies: [String]

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppTheme.shellGradient.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Profile Summary")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.textPrimary)

                    GroupBox {
                        VStack(alignment: .leading, spacing: 10) {
                            SummaryRow(label: "Name", value: name)
                            SummaryRow(label: "Occupation", value: occupation)
                            SummaryRow(label: "Email", value: email)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .groupBoxStyle(.automatic)
                    .cardContainer()

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "list.bullet")
                                .foregroundStyle(AppTheme.accent)
                            Text("Hobbies")
                                .font(.headline)
                            Spacer()
                        }

                        if hobbies.isEmpty {
                            Text("No hobbies added")
                                .foregroundStyle(.secondary)
                        } else {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(hobbies, id: \.self) { h in
                                    HStack(alignment: .top, spacing: 10) {
                                        Text("•")
                                            .foregroundStyle(AppTheme.accent)
                                        Text(h)
                                        Spacer(minLength: 0)
                                    }
                                }
                            }
                        }
                    }
                    .cardContainer()

                    Button {
                        dismiss()
                    } label: {
                        Label("Go Back", systemImage: "chevron.left")
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    .padding(.top, 6)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
        }
    }
}

private struct SummaryRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .frame(width: 110, alignment: .leading)
                .foregroundStyle(.secondary)
            Text(value.isEmpty ? "—" : value)
                .font(.body)
            Spacer()
        }
    }
}

#Preview {
    ProfileSummaryView(
        name: "John Doe",
        occupation: "Software Engineer",
        email: "john.doe@example.com",
        hobbies: ["Reading", "Traveling", "Yeye"]
    )
}


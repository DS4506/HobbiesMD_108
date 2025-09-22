//
//  AppTheme.swift
//  Hobbies
//
//  Created by Willie Earl on 9/22/25.
//



import SwiftUI

enum AppTheme {
    // Brand palette
    static let gradientTop     = Color(red: 0.10, green: 0.08, blue: 0.22)   // deep indigo
    static let gradientBottom  = Color(red: 0.16, green: 0.05, blue: 0.35)   // plum
    static let primary         = Color(red: 0.58, green: 0.30, blue: 0.98)   // violet
    static let accent          = Color(red: 0.08, green: 0.52, blue: 0.96)   // azure
    static let success         = Color(red: 0.12, green: 0.66, blue: 0.50)   // teal
    static let warning         = Color(red: 0.98, green: 0.75, blue: 0.18)
    static let card            = Color(.secondarySystemBackground)
    static let textPrimary     = Color.white
    static let textSecondary   = Color.white.opacity(0.75)

    static let shellGradient = LinearGradient(
        colors: [gradientTop, gradientBottom],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Reusable modifiers

struct CardContainer: ViewModifier {
    var padding: CGFloat = 16
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(Color.white.opacity(0.10), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 18, x: 0, y: 10)
            )
    }
}

extension View {
    func cardContainer(padding: CGFloat = 16) -> some View {
        modifier(CardContainer(padding: padding))
    }
}

// Filled rounded text field style
struct FilledField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white.opacity(0.95))
            )
    }
}

extension View {
    func filledField() -> some View { modifier(FilledField()) }
}

// Buttons
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [AppTheme.primary, AppTheme.accent],
                               startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.995 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(AppTheme.success)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.995 : 1)
    }
}

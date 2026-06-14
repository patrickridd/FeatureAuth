import SwiftUI

/// A full-screen, glassy loading veil shown while an authentication request is
/// in flight. It dims the form behind a soft scrim and presents a centered
/// card with shimmering "skeleton" bars plus a status line — communicating
/// progress with a premium, on-brand feel.
///
/// Respects **Reduce Motion** (the shimmer modifier renders calmly) and is
/// announced to VoiceOver as a single, polite status element.
public struct AuthLoadingOverlay: View {

    /// Status text shown under the skeleton (e.g. "Signing you in…").
    let message: String

    public init(message: String) {
        self.message = message
    }

    public var body: some View {
        ZStack {
            scrim
            card
        }
        .transition(.opacity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(message)
        .accessibilityAddTraits(.updatesFrequently)
    }

    private var scrim: some View {
        AuthTheme.backgroundGradient
            .opacity(0.55)
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
    }

    private var card: some View {
        VStack(spacing: 18) {
            badge
            skeletonBars
            Text(message)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(AuthTheme.textPrimary)
                .multilineTextAlignment(.center)
        }
        .padding(28)
        .frame(maxWidth: 280)
        .background(AuthTheme.fieldGlass,
                    in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(AuthTheme.socialStroke, lineWidth: 1)
        )
        .shadow(color: AuthTheme.brandSecondary.opacity(0.35), radius: 24, y: 12)
    }

    private var badge: some View {
        AuthAssets.image("AppLogo")
            .resizable().scaledToFit()
            .frame(width: 48, height: 48)
            .padding(14)
            .background(AuthTheme.logoBadge,
                        in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .authShimmer(duration: 1.4, pause: 0.2, intensity: 0.5)
    }

    private var skeletonBars: some View {
        VStack(spacing: 10) {
            skeletonBar(width: 160)
            skeletonBar(width: 120)
        }
    }

    private func skeletonBar(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(AuthTheme.separator)
            .frame(width: width, height: 12)
            .authShimmer(duration: 1.4, pause: 0.2, intensity: 0.6)
    }
}

#Preview("Loading Overlay — Light") {
    ZStack {
        AuthBackground()
        AuthLoadingOverlay(message: "Signing you in…")
    }
    .preferredColorScheme(.light)
}

#Preview("Loading Overlay — Dark") {
    ZStack {
        AuthBackground()
        AuthLoadingOverlay(message: "Creating your account…")
    }
    .preferredColorScheme(.dark)
}

import Foundation
import AuthDomain

/// Branding/copy used by the FeatureAuth screens. Pass a customized
/// instance to `AuthFlowView`, `LoginView`, or `SignUpView` to white-label
/// the experience without touching the kit's source.
public struct AuthConfiguration {
    public var appName: String
    public var loginSubtitle: String
    public var signUpSubtitle: String
    public var loginFooterPrompt: String
    public var signUpFooterPrompt: String
    /// Social providers shown on the **Login** screen, in display order.
    /// Defaults to all three. Keep a provider here (but drop it from
    /// `signUpProviders`) to let existing users keep logging in while
    /// preventing new sign-ups with it.
    public var loginProviders: [SocialAuthProvider]
    /// Social providers shown on the **Sign Up** screen, in display order.
    /// Defaults to all three. Omit any provider you want to phase out for
    /// new accounts.
    public var signUpProviders: [SocialAuthProvider]

    public init(
        appName: String? = nil,
        loginSubtitle: String? = nil,
        signUpSubtitle: String? = nil,
        loginFooterPrompt: String? = nil,
        signUpFooterPrompt: String? = nil,
        loginProviders: [SocialAuthProvider] = [.apple, .google, .facebook],
        signUpProviders: [SocialAuthProvider] = [.apple, .google, .facebook]
    ) {
        self.appName = appName ?? L10n.Config.appName
        self.loginSubtitle = loginSubtitle ?? L10n.Config.loginSubtitle
        self.signUpSubtitle = signUpSubtitle ?? L10n.Config.signUpSubtitle
        self.loginFooterPrompt = loginFooterPrompt ?? L10n.Config.loginFooterPrompt
        self.signUpFooterPrompt = signUpFooterPrompt ?? L10n.Config.signUpFooterPrompt
        self.loginProviders = loginProviders
        self.signUpProviders = signUpProviders
    }

    public static let `default` = AuthConfiguration()
}

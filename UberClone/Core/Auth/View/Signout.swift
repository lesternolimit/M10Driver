import SwiftUI
import AuthenticationServices

struct SignOutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isSignedOut = false

    var body: some View {
        VStack {
            Button(action: signOut) {
                Text("Sign Out")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isSignedOut) {
            LoginView() // Redirection vers l'écran de connexion
        }
    }

    func signOut() {
        // Efface les informations d'identification Apple
        if let userIdentifier = KeychainHelper.getUserIdentifier() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { credentialState, error in
                switch credentialState {
                case .revoked, .notFound:
                    // L'utilisateur est déconnecté, réinitialise l'état de l'application et montre l'écran de connexion
                    DispatchQueue.main.async {
                        KeychainHelper.deleteUserIdentifier()
                        isSignedOut = true
                    }
                default:
                    break
                }
            }
        }
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}


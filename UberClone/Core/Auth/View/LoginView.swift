import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var isSignedIn = false // Variable d'état pour vérifier si l'utilisateur est connecté
    
    var body: some View {
        if isSignedIn {
            // Redirection vers HomeView après connexion réussie
            HomeView()
        } else {
            ZStack {
                // Image en fond
                Image("logo") // Assure-toi que l'image "logo" est bien dans tes assets
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                // Contenu par-dessus l'image
                VStack {
                    Spacer() // Ajoute de l'espace en haut

                    SignInWithAppleButton(.signIn, onRequest: { request in
                        // Configure la requête pour obtenir les informations utilisateur
                        request.requestedScopes = [.fullName, .email]
                    }, onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            handleAuthorization(authResults)
                        case .failure(let error):
                            print("Erreur lors de la connexion avec Apple : \(error.localizedDescription)")
                        }
                    })
                    .signInWithAppleButtonStyle(.black) // Change le style si nécessaire
                    .frame(height: 48)
                    .cornerRadius(20) // Ajuste la hauteur et le style
                    .padding(.bottom, 30) // Ajoute un espacement en bas
                    .padding(.horizontal, 40)
                    .padding(.top)// Ajuste l'espacement horizontal
                    
                     // Ajoute de l'espace en bas
                }
            }
        }
    }
    
    private func handleAuthorization(_ authResults: ASAuthorization) {
        switch authResults.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Gère la connexion réussie ici
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // Logique supplémentaire comme stocker les informations utilisateur
            print("Identifiant utilisateur : \(userIdentifier)")
            print("Nom complet : \(String(describing: fullName))")
            print("Email : \(String(describing: email))")
            
            // Après la connexion réussie, on change l'état pour rediriger vers HomeView
            isSignedIn = true
            
        default:
            break
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


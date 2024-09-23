import SwiftUI

struct SlideMenu: View {
    @Binding var isShowing: Bool
    @State private var appleUserID: String = "exemple@apple.com" // Remplace avec l'ID Apple réel
    
    var body: some View {
        ZStack {
            // Background overlay to dismiss menu
            if isShowing {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
            }

            // Menu content
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    // ID Apple Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bienvenue,")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("ID Apple: \(appleUserID)")
                            .font(.title3)
                            .bold()
                    }
                    .padding(.top, 40)
                    
                    Divider()
                    
                    // Portefeuille
                    NavigationLink(destination: WalletView()) {
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(.blue)
                            Text("Portefeuille")
                                .foregroundColor(.black)
                        }
                    }
                    
                    // Code Promo
                    NavigationLink(destination: PromoCodeView()) {
                        HStack {
                            Image(systemName: "tag")
                                .foregroundColor(.green)
                            Text("Code Promo")
                                .foregroundColor(.black)
                        }
                    }
                    
                    // Historique des courses
                    NavigationLink(destination: RideHistoryView()) {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.orange)
                            Text("Historique des courses")
                                .foregroundColor(.black)
                        }
                    }
                    
                    // Support
                    NavigationLink(destination: SupportView()) {
                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(.red)
                            Text("Support")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    
                    // Déconnexion
                    Button(action: {
                        // Logic for signing out
                        isShowing = false
                    }) {
                        HStack {
                            Image(systemName: "power")
                                .foregroundColor(.red)
                            Text("Déconnexion")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 30)
                }
                .padding()
                .frame(width: 280)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 20)
                .offset(x: isShowing ? 0 : -300)
                .animation(.easeInOut)
                
                Spacer()
            }
        }
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu(isShowing: .constant(true))
    }
}


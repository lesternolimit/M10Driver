import SwiftUI
import MapKit

struct ConfirmTripView: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack {
            // 3D Map View
            CustomUberMapView(mapState: $mapState)
                .edgesIgnoringSafeArea(.all)
            
            // Rectangle de fond
            Color.white
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Rectangle derrière le texte
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 100) // Ajustez la hauteur si nécessaire
                    .cornerRadius(10)
                    .padding(.horizontal, 20) // Marges latérales
                
                // Affichage de la destination
                Text("Recherche de chauffeur")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                // Radar bleu
                RadarView()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
                
                Spacer()
                
                // Bouton annuler
                Button(action: {
                    // Redirection vers HomeView
                    mapState = .noInput
                }) {
                    Text("Annuler")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct RadarView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .stroke(Color.blue, lineWidth: 2)
            .scaleEffect(isAnimating ? 1 : 0)
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)
            )
            .onAppear {
                isAnimating = true
            }
    }
}

struct ConfirmTripView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmTripView(mapState: .constant(.idle))
            .environmentObject(LocationSearchViewModel())
    }
}


import SwiftUI
import MapKit

struct ChauffeurResultView: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    // Informations sur le chauffeur
    var chauffeurName: String
    var chauffeurRating: Double
    var arrivalTime: String
    
    var body: some View {
        ZStack {
            // 3D Map View
            CustomUberMapView(mapState: $mapState)
                .edgesIgnoringSafeArea(.all)
            
            // Rectangle de fond semi-transparent
            Color.white.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Informations sur le chauffeur
                Text("Chauffeur Accepté")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                Text("Nom: \(chauffeurName)")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text("Évaluation: \(chauffeurRating, specifier: "%.1f") ⭐️")
                    .font(.subheadline)
                    .padding(.top, 5)
                
                Text("Temps d'arrivée: \(arrivalTime)")
                    .font(.subheadline)
                    .padding(.top, 5)
                
                Spacer()
                
                // Bouton pour annuler la course
                Button(action: {
                    // Action pour annuler la course
                    mapState = .noInput
                }) {
                    Text("Annuler la course")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
    }
}

struct ChauffeurResultView_Previews: PreviewProvider {
    static var previews: some View {
        ChauffeurResultView(mapState: .constant(.idle), chauffeurName: "John Doe", chauffeurRating: 4.5, arrivalTime: "5 minutes")
            .environmentObject(LocationSearchViewModel())
    }
}


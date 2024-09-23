
import SwiftUI

struct SearchChauffeurView: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @State private var showingApplePay = false
    @State private var showingConfirmTrip = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 3D Map View
            CustomUberMapView(mapState: $mapState)
                .edgesIgnoringSafeArea(.all)
            
            // Rectangle pour l'adresse de destination
            VStack {
                Text("Votre adresse destination")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding()
                
                HStack {
                    // Apple Pay Button
                    Button(action: {
                        showingApplePay = true
                    }) {
                        Text("Apple Pay")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }

                    // Cash Button
                    Button(action: {
                        showingConfirmTrip = true // Redirection vers ConfirmTrip
                    }) {
                        Text("Cash")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .frame(height: 100)
                .edgesIgnoringSafeArea(.bottom)
            }
            .fullScreenCover(isPresented: $showingApplePay) {
                ApplePayView() // Assurez-vous que votre ApplePayView est configurée
            }
            .fullScreenCover(isPresented: $showingConfirmTrip) {
                ConfirmTripView(mapState: $mapState) // Redirection vers ConfirmTrip
            }
        }
    }
}

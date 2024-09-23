import SwiftUI

struct RideRequestView: View {
    @Binding var mapState: MapViewState
    @State private var selectedRideType: RideType = .M10eco
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @State private var showingSearchChauffeur = false

    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // Trip info view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.blue))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.blue))
                        .frame(width: 1, height: 32)
                    
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Current location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        if let location = locationViewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            // Ride type selection view
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFill()
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(type.description)
                                    .font(.system(size: 12, weight: .semibold))
                                
                                Text(locationViewModel.computeRidePrice(for: type).toCurrency())
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 120, height: 140)
                        .foregroundColor(type == selectedRideType ? .white : Color.theme.primaryTextColor)
                        .background(type == selectedRideType ? .blue : Color.theme.secondaryBackgroundColor)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            // Bouton de confirmation pour passer à la recherche de chauffeur
            Button {
                showingSearchChauffeur = true // On affiche SearchChauffeurView
            } label: {
                Text("CONFIRM RIDE")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $showingSearchChauffeur) {
                SearchChauffeurView(mapState: $mapState) // Passer mapState correctement
            }
        }
        .padding(.bottom, 24)
        .background(Color.white) // Fond solide
        .cornerRadius(34)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        let mapState: MapViewState = .idle
        RideRequestView(mapState: Binding.constant(mapState))
            .environmentObject(LocationSearchViewModel())
    }
}


import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @Binding var showMenu: Bool
    @EnvironmentObject var viewModel: LocationSearchViewModel

    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForSate(mapState)
                showMenu.toggle() // Affiche ou masque le menu
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.blue)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .blue, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func actionForSate(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("No Input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .rideRequested:
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        case .idle:
            // Ajouter la logique spécifique pour l'état idle ici, si nécessaire
            break
        case .searching:
            // Ajouter la logique spécifique pour l'état searching ici, si nécessaire
            break
        case .selected:
            // Ajouter la logique spécifique pour l'état selected ici, si nécessaire
            break
        case .destinationSet:
            break
        case .driverSearching:
            break
        }
    }

    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .rideRequested:
            return "arrow.left"
        case .idle:
            return "house"
        case .searching:
            return "magnifyingglass"
        case .selected:
            return "pin"
        case .destinationSet:
            return "destination"
        case .driverSearching:
            return "driverSearch"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput), showMenu: .constant(false))
            .environmentObject(LocationSearchViewModel())
    }
}


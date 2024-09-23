import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @State private var isShowingSlideMenu = false
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    CustomUberMapView(mapState: $mapState)
                        .ignoresSafeArea()
                    
                    if mapState == .searchingForLocation {
                        LocationSearchView(mapState: $mapState)
                    } else if mapState == .noInput {
                        LocationSearchActivationView()
                            .padding(.top, 72)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    mapState = .searchingForLocation
                                }
                            }
                    }
                    
                    MapViewActionButton(mapState: $mapState, showMenu: $isShowingSlideMenu)
                        .padding(.leading)
                        .padding(.top, 4)
                }
                
                if mapState == .locationSelected || mapState == .rideRequested {
                    RideRequestView(mapState: $mapState)
                        .transition(.move(edge: .bottom))
                }
                
                if isShowingSlideMenu {
                    SlideMenu(isShowing: $isShowingSlideMenu)
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    locationViewModel.userLocation = location
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationSearchViewModel())
    }
}


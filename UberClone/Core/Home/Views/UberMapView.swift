import SwiftUI
import MapKit

struct CustomUberMapView: UIViewRepresentable {
    let mapView = MKMapView()
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = true // Autorise la rotation de la carte
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        setCameraFor3D() // Configure la vue en 3D lors de la création de la vue
        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
        case .rideRequested:
            break
        case .idle:
            break
        case .searching:
            break
        case .selected:
            break
        case .destinationSet:
            break
        case .driverSearching:
            break
        }
    }

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }

    func setCameraFor3D() {
        let camera = MKMapCamera()
        camera.centerCoordinate = mapView.centerCoordinate
        camera.pitch = 70 // Inclinaison pour la vue 3D
        camera.altitude = 1000 // Altitude pour maintenir une vue éloignée
        camera.heading = 0 // Direction de la carte (optionnel)
        mapView.setCamera(camera, animated: true)
    }
}

extension CustomUberMapView {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: CustomUberMapView
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?

        init(parent: CustomUberMapView) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)
            )
            self.currentRegion = region

            // Ajout de la caméra pour la vue 3D
            parent.setCameraFor3D()
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }

        // MARK: - Helpers

        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }

        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .rideRequested
                let rect = self.parent.mapView.mapRectThatFits(
                    route.polyline.boundingMapRect,
                    edgePadding: .init(
                        top: 64,
                        left: 32,
                        bottom: 500,
                        right: 32
                    )
                )
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}


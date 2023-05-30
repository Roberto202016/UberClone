//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Computo 3 on 04/05/23.
//

import SwiftUI
import MapKit

//La estructura UberMapViewRepresentable conforma el protocolo UIViewRepresentable, lo que 
//permite integrar una vista de UIKit en una interfaz de SwiftUI. Esta estructura tiene 
//varias propiedades y métodos para configurar y gestionar el mapa.

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    //En el método makeUIView, se crea una instancia de MKMapView y se configuran algunas 
    //propiedades, como el delegado, la habilidad de rotación, la visualización de la ubicación del usuario y 
    //el modo de seguimiento del usuario. Luego, se devuelve la vista del mapa creada.

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    //El método updateUIView se llama cuando se producen cambios en la vista y se encarga de actualizar 
    //el estado del mapa según el valor de la variable mapState. Dependiendo del valor de mapState, se 
    //ejecutan diferentes acciones. Por ejemplo, cuando mapState es .noInput, se llama al método 
    //clearMapViewAndRecenterOnUserLocation del coordinador para limpiar el mapa y centrarlo en la ubicación del usuario.

    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
                print("DEBUG: Adding stuff to map..")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        }
    }

    //El método makeCoordinator() crea una instancia de MapCoordinator y la inicializa 
    //con el parámetro parent establecido como self, que hace referencia a la instancia 
    //actual de UberMapViewRepresentable. Luego, devuelve este coordinador recién creado.

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

//La extensión UberMapViewRepresentable contiene la clase interna MapCoordinator, que actúa 
//como delegado del mapa y se encarga de manejar eventos relacionados con el mapa. El coordinador 
//tiene propiedades como parent (una referencia a la estructura UberMapViewRepresentable), 
//userLocationCoordinate (que almacena las coordenadas de la ubicación del usuario) y currentRegion 
//(que almacena la región actual del mapa).

extension UberMapViewRepresentable {

    class MapCoordinator: NSObject, MKMapViewDelegate {

        //MARK: - Properties

        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?

        //MARK: - Lifecycle

        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        //MARK: - MKMapViewDelegate

        //El coordinador implementa el protocolo MKMapViewDelegate y define métodos como mapView(_:didUpdate:), 
        //que se llama cuando se actualiza la ubicación del usuario y se utiliza para establecer la región del 
        //mapa centrada en la ubicación actual del usuario.

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )

            self.currentRegion = region

            parent.mapView.setRegion(region, animated: true)
        }

        //También se implementa el método mapView(_:rendererFor:) para personalizar la apariencia de las 
        //superposiciones en el mapa, en este caso, se crea un MKPolylineRenderer para representar las rutas 
        //en el mapa.

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }

        //MARK: - Helpers

        //El coordinador tiene otros métodos auxiliares como addAndSelectAnnotation(withCoordinate:) para 
        //agregar y seleccionar una anotación en el mapa.

        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)

            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
        }

        //El configurePolyline(withDestinationCoordinate:) para configurar una superposición de ruta en el mapa.

        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        //El clearMapViewAndRecenterOnUserLocation() para limpiar el mapa y centrarlo en la ubicación del usuario.

        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)

            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}

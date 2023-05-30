//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Computo 3 on 16/05/23.
//

import Foundation
import MapKit

//Define una clase llamada LocationSearchViewModel que actúa como un modelo de vista 
//en una aplicación de búsqueda de ubicaciones. Esta clase se utiliza para realizar 
//búsquedas de ubicaciones, seleccionar una ubicación y realizar cálculos relacionados 
//con las ubicaciones.


//La clase LocationSearchViewModel hereda de NSObject y adopta el protocolo 
//ObservableObject, lo que significa que se puede utilizar como un objeto observable 
//en SwiftUI.
class LocationSearchViewModel: NSObject, ObservableObject {

    // MARK: - Properties

    //results: Es una matriz observable de tipo MKLocalSearchCompletion. 
    //Almacena los resultados de búsqueda de ubicaciones completadas por 
    //MKLocalSearchCompleter.
    @Published var results = [MKLocalSearchCompletion]()

    //selectedUberLocation: Es una ubicación seleccionada representada 
    //por un objeto UberLocation. Es una propiedad observable y se 
    //actualiza cuando se selecciona una ubicación en la aplicación.
    @Published var selectedUberLocation: UberLocation?

    //pickupTime y dropOffTime: Son cadenas que representan la hora de recogida y la 
    //hora de llegada respectivamente. Estas propiedades se actualizan y se utilizan 
    //para mostrar los tiempos de recogida y llegada estimados.
    @Published var pickupTime: String?
    @Published var dropOffTime: String?

    //searchCompleter: Es una instancia de MKLocalSearchCompleter 
    //que se utiliza para realizar búsquedas de ubicaciones.
    private let searchCompleter = MKLocalSearchCompleter()

    //queryFragment: Es una cadena que representa el fragmento de consulta utilizado 
    //para realizar búsquedas de ubicaciones. Cuando se actualiza esta propiedad, se 
    //actualiza el queryFragment de searchCompleter.
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }

    //userLocation: Es una coordenada de tipo CLLocationCoordinate2D 
    //que representa la ubicación del usuario.
    var userLocation: CLLocationCoordinate2D?

    // MARK: Lifecycle

    //init(): Es el método de inicialización de la clase. 
    //Configura searchCompleter y establece el queryFragment inicial.
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }

    // MARK: Helpers

    //selectLocation(_:): Este método se utiliza para seleccionar una 
    //ubicación de búsqueda. Toma un objeto MKLocalSearchCompletion y 
    //realiza una búsqueda de ubicación correspondiente utilizando 
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {

        //locationSearch(forLocalSearchCompletion:completion:). 
        //Una vez que se obtiene la respuesta, se configura 
        //selectedUberLocation con los detalles de la ubicación seleccionada.
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }

            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            print("DEBUG: Location coordinates \(coordinate)")
        }
    }

    //locationSearch(forLocalSearchCompletion:completion:): Este método realiza una búsqueda de 
    //ubicación utilizando MKLocalSearch. Toma un objeto MKLocalSearchCompletion y realiza una 
    //búsqueda de ubicación utilizando la cadena de título y subtítulo del objeto de búsqueda. 
    //La respuesta se devuelve a través del parámetro de finalización.
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)

        search.start(completionHandler: completion)
    }

    //computeRidePrice(forType:): Este método calcula el precio estimado de un viaje para un 
    //tipo de viaje específico (RideType). Utiliza las coordenadas de la ubicación seleccionada 
    //(selectedUberLocation) y la ubicación del usuario (userLocation) para calcular la distancia 
    //entre las ubicaciones utilizando CLLocation y luego utiliza el método computePrice(for:) del 
    //tipo de viaje para obtener el precio estimado del viaje.
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0}

        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)

        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }

    //getDestinationRoute(from:to:completion:): Este método obtiene la ruta entre la ubicación 
    //del usuario y el destino seleccionado utilizando MKDirections. Toma las coordenadas de 
    //la ubicación del usuario y el destino, crea objetos MKPlacemark para cada ubicación y 
    //configura una solicitud de dirección utilizando estos placemarks. Luego, utiliza MKDirections 
    //para calcular la ruta y devuelve la ruta a través del parámetro de finalización.
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()

        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)

        let directions = MKDirections(request: request)

        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get directions with error \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }

    //configurePickupAndDropoffTimes(with:): Este método configura las horas de recogida 
    //y llegada estimadas en función del tiempo de viaje esperado. Utiliza DateFormatter 
    //para formatear la hora actual y la hora de llegada estimada.
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

//mark: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {

    //completerDidUpdateResults(_:): Este método del delegado se llama cuando 
    //se actualizan los resultados de búsqueda de MKLocalSearchCompleter. Actualiza 
    //la propiedad results con los nuevos resultados.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

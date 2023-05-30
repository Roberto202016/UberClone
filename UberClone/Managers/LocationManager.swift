//
//  LocationManager.swift
//  UberClone
//
//  Created by Computo 3 on 04/05/23.
//

import CoreLocation

//La clase llamada LocationManager que hereda de NSObject e implementa el protocolo ObservableObject. 
//Además, se extiende la clase LocationManager para conformarse al protocolo CLLocationManagerDelegate.

//La clase LocationManager se encarga de administrar la ubicación del usuario utilizando la clase 
//CLLocationManager de Core Location.

class LocationManager: NSObject, ObservableObject {

    //Se crea una instancia de CLLocationManager llamada locationManager como propiedad 
    //privada de la clase LocationManager.
    private let locationManager = CLLocationManager()

    //Se define una propiedad estática llamada shared de tipo LocationManager. Esto 
    //permite acceder a una única instancia de LocationManager en toda la aplicación 
    //utilizando LocationManager.shared.
    static let shared = LocationManager()

    //Se define una propiedad publicada userLocation de tipo CLLocationCoordinate2D?. 
    //Esta propiedad se utilizará para almacenar las coordenadas de la ubicación del 
    //usuario y se publicará automáticamente cuando cambie su valor.
    @Published var userLocation: CLLocationCoordinate2D?

    //En el método init(), que es el inicializador de la clase LocationManager, se configuran 
    //varias propiedades del locationManager. Se establece el delegado como self (la instancia 
    //actual de LocationManager), la precisión deseada como kCLLocationAccuracyBest (la máxima 
    //precisión disponible), se solicita autorización para usar la ubicación cuando la aplicación 
    //esté en uso y se inicia la actualización de la ubicación del usuario.

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

//La extensión de LocationManager implementa el método locationManager(_:didUpdateLocations:) 
//del protocolo CLLocationManagerDelegate. Este método se llama cuando se actualizan las ubicaciones. 
//Dentro del método, se verifica si se obtuvo al menos una ubicación en el parámetro locations. 
//Si es así, se guarda la primera ubicación en la propiedad userLocation y se detiene la actualización 
//de la ubicación del usuario.

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}

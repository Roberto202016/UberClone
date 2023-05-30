//
//  UberLocation.swift
//  UberClone
//
//  Created by Computo 3 on 26/05/23.
//

import CoreLocation

//Define una estructura llamada UberLocation. Esta estructura representa
//una ubicación en el contexto de la aplicación Uber.

struct UberLocation {

    //title: Una cadena de texto que representa el título o nombre de la ubicación.
    let title: String

    //coordinate: Un objeto de tipo CLLocationCoordinate2D que representa las 
    //coordenadas geográficas de la ubicación.
    let coordinate: CLLocationCoordinate2D
}

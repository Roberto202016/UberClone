//
//  RideType.swift
//  UberClone
//
//  Created by Computo 3 on 25/05/23.
//

import Foundation

//Define un enumerado llamado RideType. Este enumerado representa los diferentes 
//tipos de viajes disponibles en una aplicación de transporte, como Uber.

//El enumerado RideType tiene tres casos: .uberX, .black y .uberXL. Cada 
//caso está asociado con un valor entero subyacente (Int) que se utiliza como 
//identificador (id) del caso.

//El enumerado también implementa el protocolo Identifiable, lo que significa 
//que cada caso tiene un identificador único. En este caso, el identificador se 
//obtiene del valor entero subyacente utilizando la propiedad computada id.

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL

    var id: Int { return rawValue }

    //description: Esta propiedad computada devuelve una descripción legible 
    //para cada caso del enumerado. Dependiendo del caso, devuelve una cadena 
    //de texto como "UberX", "UberBlack" o "UberXL".

    var description: String {
        switch self {
            case .uberX: return "UberX"
            case .black: return "UberBlack"
            case .uberXL: return "UberXL"
        }
    }

    //imageName: Esta propiedad computada devuelve el nombre de la 
    //imagen asociada a cada caso del enumerado. Depende del caso y devuelve 
    //una cadena de texto que representa el nombre de la imagen correspondiente.

    var imageName: String {
        switch self {
            case .uberX: return "uber-X"
            case .black: return "uber-black"
            case .uberXL: return "uber-X"
        }
    }

    //baseFare: Esta propiedad computada devuelve la tarifa base para 
    //cada caso del enumerado. Dependiendo del caso, devuelve un valor 
    //de tipo Double que representa la tarifa base para ese tipo de viaje.

    var baseFare: Double {
        switch self {
            case .uberX: return 5
            case .black: return 20
            case .uberXL: return 10
        }
    }

    //computePrice(for distanceInMeters: Double): Este método calcula el 
    //precio estimado de un viaje en función de la distancia proporcionada 
    //en metros. Primero, convierte la distancia en millas dividiéndola por 1600 
    //(aproximadamente la cantidad de metros en una milla). Luego, utiliza una 
    //estructura de control switch para calcular el precio según el tipo de viaje 
    //y la fórmula específica para cada caso.

    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600

        switch self {
            case .uberX: return distanceInMiles * 1.5 + baseFare
            case .black: return distanceInMiles * 2.0 + baseFare
            case .uberXL: return distanceInMiles * 1.75 + baseFare
        }
    }
}

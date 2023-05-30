//
//  MapViewState.swift
//  UberClone
//
//  Created by Computo 3 on 23/05/23.
//

import Foundation

//Define un enumerado llamado MapViewState. Este enumerado representa los posibles estados de 
//una vista de mapa en una aplicación.

enum MapViewState {

    //noInput: Este caso representa el estado en el que no se ha ingresado ninguna entrada 
    //en la vista de mapa. Es decir, no hay ninguna acción o selección realizada por el usuario 
    //en relación con la ubicación en el mapa.
    case noInput

    //searchingForLocation: Este caso representa el estado en el que se está realizando una 
    //búsqueda de ubicación en la vista de mapa. Esto podría significar que el usuario está 
    //ingresando un lugar o dirección para buscar en el mapa.
    case searchingForLocation

    //locationSelected: Este caso representa el estado en el que se ha seleccionado una 
    //ubicación en la vista de mapa. Puede indicar que el usuario ha elegido una ubicación 
    //específica en el mapa.
    case locationSelected

    //polylineAdded: Este caso representa el estado en el que se ha agregado una polilínea 
    //(línea que conecta puntos) en la vista de mapa. Esto podría indicar que se ha trazado 
    //una ruta o se ha agregado una línea para representar una conexión entre ubicaciones.
    case polylineAdded
}

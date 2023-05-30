//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Computo 3 on 04/05/23.
//

import SwiftUI


//@main: El atributo @main se aplica a la estructura UberCloneApp 
//y se utiliza para indicar que esta estructura es el punto de entrada 
//principal de la aplicación.
@main

//@StateObject var locationViewModel = LocationSearchViewModel(): Esta línea declara una propiedad 
//envuelta en @StateObject llamada locationViewModel, que es una instancia de LocationSearchViewModel. 
//La propiedad envuelta en @StateObject es una propiedad observable que se mantiene durante la vida útil 
//de la aplicación y se actualiza automáticamente cuando cambian sus valores internos. En este caso, 
//se crea una instancia de LocationSearchViewModel y se asigna a locationViewModel.
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    //var body: some Scene: Esta es la función de la propiedad body, 
    //que define la estructura de la interfaz de usuario de la aplicación.
    var body: some Scene {
        
        //WindowGroup: WindowGroup es un contenedor para la interfaz de 
        //usuario principal de la aplicación. En este caso, la vista 
        //principal de la aplicación se representa mediante la vista HomeView().
        WindowGroup {

            //.environmentObject(locationViewModel): Este modificador se 
            //utiliza para inyectar el objeto locationViewModel en el entorno 
            //de la vista principal (HomeView). Esto permite que HomeView acceda 
            //al objeto locationViewModel y utilice sus propiedades y métodos. 
            //Al utilizar environmentObject, el objeto locationViewModel se 
            //vuelve accesible en cualquier vista descendiente de HomeView.
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}

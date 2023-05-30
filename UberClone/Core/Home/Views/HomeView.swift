//
//  HomeView.swift
//  UberClone
//
//  Created by Computo 3 on 04/05/23.
//

import SwiftUI

//Define la estructura HomeView, que representa la 
//vista principal de la aplicación en un clon de Uber.
struct HomeView: View {

    //@State private var mapState = MapViewState.noInput: mapState es una propiedad 
    //de estado que mantiene el estado actual del mapa. Se inicializa con el valor 
    //noInput del enumerado MapViewState. El modificador @State se utiliza para indicar 
    //que esta propiedad es mutable y está sujeta a cambios.
    @State private var mapState = MapViewState.noInput

    //@EnvironmentObject var locationViewModel: LocationSearchViewModel: locationViewModel 
    //es una propiedad que utiliza el objeto de ambiente LocationSearchViewModel, que se 
    //comparte en toda la aplicación. Esto permite acceder y modificar el estado y los 
    //datos del modelo de vista de ubicación desde esta vista.
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    var body: some View{

        //ZStack: ZStack se utiliza para apilar vistas una encima de la otra en el 
        //eje Z. Aquí, se utiliza para apilar las vistas del mapa y otras vistas relacionadas.
        //ZStack(alignment: .top): Esta es otra instancia de ZStack que se utiliza para 
        //apilar las vistas del mapa y las vistas superiores, alineadas en la parte superior.
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {

                //UberMapViewRepresentable(mapState: $mapState): Aquí se utiliza UberMapViewRepresentable, 
                //que es un representante de la interfaz de usuario de MKMapView (mapa de MapKit) adaptado 
                //para SwiftUI. Recibe el estado del mapa mapState como un enlace (Binding), lo que permite 
                //actualizar el estado del mapa desde esta vista.
                UberMapViewRepresentable(mapState: $mapState)
                    
                    //ignoresSafeArea(): Este modificador se aplica a UberMapViewRepresentable y le indica 
                    //a la vista que ignore los márgenes seguros, lo que permite que ocupe todo el espacio disponible.
                    .ignoresSafeArea()

                    //if mapState == .searchingForLocation: Este bloque condicional verifica si el 
                    //estado del mapa es searchingForLocation. Si es verdadero, se muestra LocationSearchView, 
                    //que es una vista de búsqueda de ubicación para permitir al usuario buscar una ubicación.
                    if mapState == .searchingForLocation {
                        LocationSearchView(mapState: $mapState)

                    //else if mapState == .noInput: Este bloque condicional verifica si el estado del mapa es 
                    //noInput. Si es verdadero, se muestra LocationSearchActivationView, que es una vista que 
                    //se muestra inicialmente y se puede tocar para activar la búsqueda de ubicación.
                    } else if mapState == .noInput {
                        LocationSearchActivationView()
                            .padding(.top, 72)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    mapState = .searchingForLocation
                                }
                            }
                    }
            
            //MapActionButton(mapState: $mapState): Esta es una vista que muestra 
            //un botón relacionado con el mapa, y su estado también se enlaza con mapState. 
            //El botón puede tener diferentes funcionalidades dependiendo del estado del mapa.
            MapViewActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top, 4)
            }

            //if mapState == .locationSelected || mapState == .polylineAdded: Este bloque condicional 
            //verifica si el estado del mapa es locationSelected o polylineAdded. Si es verdadero, se 
            //muestra RideRequestView, que es una vista para solicitar un viaje.
            if mapState == .locationSelected || mapState == .polylineAdded {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }

        //.edgesIgnoringSafeArea(.bottom): Este modificador se aplica a la vista principal y le 
        //indica que ignore los márgenes seguros en la parte inferior, lo que permite que la vista 
        //se extienda hasta el borde inferior de la pantalla.
        .edgesIgnoringSafeArea(.bottom)

        //.onReceive(LocationManager.shared.$userLocation) { location in ... }: Este modificador 
        //se aplica a la vista principal y se utiliza para recibir actualizaciones del objeto 
        //compartido LocationManager cuando cambia la ubicación del usuario
        .onReceive(LocationManager.shared.$userLocation) {
            location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

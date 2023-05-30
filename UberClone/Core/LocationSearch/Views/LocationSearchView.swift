//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Computo 3 on 09/05/23.
//

import SwiftUI

//Define la estructura LocationSearchView, que representa la vista de búsqueda de ubicación en la aplicación.
struct LocationSearchView: View {

    //@State private var startLocationText = "": Esta es una propiedad de estado que almacena el texto 
    //de la ubicación de inicio actual. Se utiliza para enlazar el valor de un campo de texto.
    @State private var startLocationText = ""

    //@Binding var mapState: MapViewState: Esta es una propiedad de enlace que representa el 
    //estado del mapa. Se utiliza para comunicar el estado actual del mapa entre diferentes vistas.
    @Binding var mapState: MapViewState

    //@EnvironmentObject var viewModel: LocationSearchViewModel: Esta es una propiedad de entorno 
    //que se utiliza para acceder a una instancia compartida de LocationSearchViewModel. Proporciona 
    //acceso a los datos y la lógica relacionados con la búsqueda de ubicación.
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            // Header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)

                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{

                //TextField("Current location", text: $startLocationText) ...: Esto crea un campo de texto donde 
                //el usuario puede ingresar la ubicación actual. El valor del campo de texto está vinculado a la 
                //propiedad de estado startLocationText. El texto ingresado se almacena en startLocationText.
                TextField("Current location", text: $startLocationText)
                    .frame(height: 32)
                    .background(Color(.systemGroupedBackground))
                    .padding(.trailing)

                //TextField("Where to?", text: $viewModel.queryFragment) ...: Esto crea otro campo de 
                //texto donde el usuario puede ingresar la ubicación a la que desea ir. El valor del 
                //campo de texto está vinculado a la propiedad queryFragment del LocationSearchViewModel. 
                //El texto ingresado se almacena en queryFragment.
                TextField("Where to?", text: $viewModel.queryFragment)
                    .frame(height: 32)
                    .background(Color(.systemGray4))
                    .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)

            Divider()
                .padding(.vertical)

            // list view

            //ScrollView { ... }: Esta es una vista de desplazamiento que contiene la lista de 
            //resultados de búsqueda. Permite desplazar el contenido si hay más elementos de los 
            //que caben en la pantalla.
            ScrollView{
                VStack(alignment: .leading) {

                    //ForEach(viewModel.results, id: \.self) { result in ... }: Esto itera sobre 
                    //los resultados de búsqueda almacenados en la propiedad results del LocationSearchViewModel 
                    //y crea una vista LocationSearchResultCell para cada resultado.
                    ForEach(viewModel.results, id: \.self) { result in

                        //LocationSearchResultCell(title: result.title, subtitle: result.subtitle) ...: Esta es una vista 
                        //personalizada LocationSearchResultCell que muestra el título y el subtítulo de cada resultado de 
                        //búsqueda. Al tocar una celda, se selecciona la ubicación correspondiente y se actualiza el estado del mapa.
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}

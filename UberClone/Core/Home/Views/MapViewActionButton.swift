//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Computo 3 on 09/05/23.
//

import SwiftUI

//Define la estructura MapViewActionButton, que es una vista que muestra un botón relacionado con el mapa. 
struct MapViewActionButton: View {

    //@Binding var mapState: MapViewState: mapState es un enlace (Binding) a una variable mapState 
    //de tipo MapViewState. Este enlace se utiliza para poder leer y actualizar el estado del mapa desde esta vista.
    @Binding var mapState: MapViewState

    //@EnvironmentObject var viewModel: LocationSearchViewModel: viewModel es una propiedad que utiliza 
    //el objeto de ambiente LocationSearchViewModel, que se comparte en toda la aplicación. Esto permite 
    //acceder y modificar el estado y los datos del modelo de vista de ubicación desde esta vista.
    @EnvironmentObject var viewModel: LocationSearchViewModel

    var body: some View {

        //Button { ... } label: { ... }: Este es el contenido del botón. Cuando se presiona el botón, 
        //se ejecuta el código dentro del cierre { ... }. El contenido del botón se define dentro del bloque label: { ... }.
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            //Image(systemName: imageNameForState(mapState)): Se muestra una imagen del sistema en 
            //función del estado actual del mapa. El nombre de la imagen se determina llamando a la función imageNameForState.
            Image(systemName: imageNameForState(mapState))

                //.font(.title2): Se aplica un tamaño de fuente de .title2 a la imagen.
                .font(.title2)

                //.foregroundColor(.black): Se establece el color del primer plano de la imagen en negro.
                .foregroundColor(.black)

                //.padding(): Se aplica un relleno alrededor de la imagen.
                .padding()

                //.background(.white): Se establece un fondo blanco para la imagen.
                .background(.white)

                //.clipShape(Circle()): Se aplica una forma circular a la imagen, lo que la convierte en un botón redondo.
                .clipShape(Circle())

                //.shadow(color: .black, radius: 6): Se agrega una sombra a la imagen con color negro y un radio de 6.
                .shadow(color: .black, radius: 6)
        }
        //.frame(maxWidth: .infinity, alignment: .leading): Se aplica un marco que extiende 
        //el botón hasta el ancho máximo y se alinea a la izquierda.
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    //func actionForState(_ state: MapViewState) { ... }: Esta función toma el estado 
    //actual del mapa como argumento y realiza una acción correspondiente en función de 
    //ese estado. Por ejemplo, si el estado es searchingForLocation, se cambia el estado del mapa a noInput.
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("DEBUG: No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .polylineAdded:
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        }
    }

    //func imageNameForState(_ state: MapViewState) -> String { ... }: Esta función toma 
    //el estado actual del mapa como argumento y devuelve el nombre de la imagen del sistema 
    //correspondiente a ese estado. Por ejemplo, si el estado es noInput, se devuelve "line.3.horizontal".
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
    }
}

//MapViewActionButton(mapState: .constant(.noInput)): Esto es una vista de previsualización para 
//mostrar cómo se ve MapViewActionButton con un estado inicial de noInput.
struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}

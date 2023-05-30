//
//  RideRequestView.swift
//  UberClone
//
//  Created by Computo 3 on 23/05/23.
//

import SwiftUI

//Define la estructura RideRequestView, que representa la vista de solicitud de viaje en la aplicación.
struct RideRequestView: View {

    //@State private var selectedRideType: RideType = .uberX: Esta es una propiedad de estado que almacena 
    //el tipo de viaje seleccionado. Por defecto, se establece en .uberX. Se utiliza para realizar un seguimiento 
    //del tipo de viaje elegido por el usuario.
    @State private var selectedRideType: RideType = .uberX

    //@EnvironmentObject var locationViewModel: LocationSearchViewModel: Esta es una propiedad de entorno que 
    //se utiliza para acceder a una instancia compartida de LocationSearchViewModel. Proporciona acceso a los 
    //datos y la lógica relacionados con la búsqueda de ubicación.
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // trip info view
            HStack {
                // indicator view
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)

                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {

                        //TextField("Current location", text: $startLocationText) ...: Esto crea un campo de texto donde se 
                        //muestra la ubicación de inicio actual. El texto del campo de texto se actualiza mediante la propiedad 
                        //de estado locationViewModel.pickupTime.
                        Text("Current location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Spacer()

                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)

                    HStack {

                        //TextField("Where to?", text: $viewModel.queryFragment) ...: Esto crea un campo de texto donde 
                        //se muestra la ubicación de destino seleccionada. El texto del campo de texto se actualiza mediante 
                        //la propiedad de estado locationViewModel.dropOffTime.
                        if let location = locationViewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                        }

                        Spacer()

                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 8)
            }
            .padding()

            Divider()

            // ride type selection view

            //Text("SUGGESTED RIDES") ...: Esta es una etiqueta de texto que muestra el título de los tipos de viaje sugeridos.
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)


            //ScrollView(.horizontal) { ... }: Esto crea un área de desplazamiento horizontal que contiene los tipos de viaje sugeridos.
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {

                            //Image(type.imageName) ...: Esto muestra la imagen del tipo de viaje.
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {

                                //Text(type.description) ...: Esto muestra la descripción del tipo de viaje.
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))

                                //Text(locationViewModel.computeRidePrice(forType: type).toCurrency()) ...: Esto 
                                //muestra el precio del viaje para el tipo de viaje específico.
                                Text(locationViewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()

                        }
                        .frame(width: 112, height: 140)
                        .foregroundColor(type == selectedRideType ? .white : Color.theme.primaryTextColor)
                        .background(type == selectedRideType ? .blue : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)

                        //.onTapGesture { ... }: Este modificador permite que la vista responda a un gesto de toque. 
                        //Al tocar una vista de tipo de viaje, se selecciona el tipo de viaje correspondiente.
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            Divider()
                .padding(.vertical, 8)

            // payment option view
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)

            // request ride button

            //Button { ... } label: { ... }: Esto crea un botón de solicitud de viaje. Al tocar 
            //el botón, se activa una acción, pero en el código que proporcionaste, la acción aún no está implementada.
            Button {

            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 24)

        //.background(Color.theme.backgroundColor): Este modificador establece el color de fondo 
        //de la vista en un color definido por el tema.
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}

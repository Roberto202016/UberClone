//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Computo 3 on 09/05/23.
//

import SwiftUI

//Define la estructura LocationSearchResultCell, que representa una celda de resultados de búsqueda de ubicación.
struct LocationSearchResultCell: View {

    //let title: String y let subtitle: String: Estas son las propiedades de la estructura que 
    //representan el título y el subtítulo de la celda de resultados de búsqueda de ubicación. 
    //Estas propiedades son constantes y se proporcionan al inicializar una instancia de LocationSearchResultCell.
    let title: String
    let subtitle: String

    var body: some View {
        HStack {

            //Image(systemName: "mappin.circle.fill") ...: Esta es una vista de imagen que muestra un sistema de 
            //iconos de SF Symbols llamado "mappin.circle.fill". La imagen es redimensionable y se establece el 
            //color de relleno en azul, el color de acento en blanco, y se le da un tamaño de cuadro de 40x40 puntos.
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 4) {

                //Text(title) ...: Esta es una vista de texto que muestra el título proporcionado. El texto 
                //se muestra en la fuente .body, que es una fuente de tamaño estándar.
                Text(title)
                    .font(.body)

                //Text(subtitle) ...: Esta es otra vista de texto que muestra el subtítulo proporcionado. 
                //El texto se muestra en la fuente .system(size: 15), que es una fuente de tamaño personalizado, 
                //y se establece el color del texto en gris.
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {

        //LocationSearchResultCell(title: "Starbucks", subtitle: "123 Main St"): Esto es una vista de previsualización 
        //para mostrar cómo se ve LocationSearchResultCell con un título de "Starbucks" y un subtítulo de "123 Main St".
        LocationSearchResultCell(title: "Starbucks", subtitle: "123 Main St")
    }
}

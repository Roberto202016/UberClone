//
//  Color.swift
//  UberClone
//
//  Created by Computo 3 on 26/05/23.
//

import SwiftUI

//La idea detrás de este código es proporcionar un punto centralizado para definir y acceder a los colores 
//temáticos utilizados en una aplicación SwiftUI. Al tener un ColorTheme y una propiedad estática theme en Color, 
//se puede acceder a los colores temáticos de manera más legible y mantenible. Por ejemplo, en lugar de usar 
//directamente "BackgroundColor", se puede acceder a Color.theme.backgroundColor para obtener el color temático de fondo.

extension Color {
    //La propiedad estática theme de la extensión Color devuelve una instancia de ColorTheme. Esto significa 
    //que se puede acceder a los colores definidos en ColorTheme a través de la propiedad theme en cualquier 
    //parte del código donde se utilice la estructura Color.

    static let theme = ColorTheme()
}


//La estructura ColorTheme es una estructura personalizada que contiene varias propiedades de tipo Color. 
//Cada propiedad de color se inicializa con un nombre de color específico que se utiliza como referencia 
//para buscar un color definido en los recursos de la aplicación. Por ejemplo, "BackgroundColor", "SecondaryBackgroundColor",
//"PrimaryTextColor" son nombres de colores utilizados como referencia.
struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}

//
//  Double.swift
//  UberClone
//
//  Created by Computo 3 on 26/05/23.
//

import Foundation

//Es una extensión de la estructura Double en Swift que agrega un método llamado toCurrency(). 
//Esta extensión proporciona una forma conveniente de formatear un número Double en formato de 
//moneda utilizando NumberFormatter.

extension Double {

    //La extensión comienza definiendo una propiedad computada llamada currencyFormatter. 
    //Esta propiedad es privada porque solo se usa dentro de la extensión. La propiedad currencyFormatter
    //es una instancia de NumberFormatter, una clase proporcionada por Foundation que se utiliza para 
    //formatear números.

    private var currencyFormatter: NumberFormatter {

        //Dentro de currencyFormatter, se configuran algunas propiedades para formatear el número como una moneda. 
        //Primero, se establece el estilo de número en .currency, lo que indica que se formateará como una moneda. 
        //Luego, se establecen minimumFractionDigits y maximumFractionDigits en 2. Esto significa que el número se 
        //formateará con un mínimo de 2 dígitos decimales y un máximo de 2 dígitos decimales.

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    //El método toCurrency() toma un valor Double y utiliza el currencyFormatter definido anteriormente para formatear 
    //el número en formato de moneda. Utiliza el método string(for:) de NumberFormatter para convertir el número en una 
    //cadena de texto con formato de moneda. Si el formateo es exitoso, devuelve la cadena de texto resultante. Si el 
    //formateo falla por alguna razón, devuelve una cadena de texto vacía.

    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}

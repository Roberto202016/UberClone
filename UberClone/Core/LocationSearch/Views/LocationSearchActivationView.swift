//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Computo 3 on 09/05/23.
//

import SwiftUI

//Define la estructura LocationSearchActivationView, que es una vista que representa la activación de la búsqueda de ubicación.
struct LocationSearchActivationView: View {
    var body: some View {

        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            
            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider{
    static var previews: some View{
        LocationSearchActivationView()
    }
}

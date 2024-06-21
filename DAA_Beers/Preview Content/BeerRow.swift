//
//  BeerRow.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 27/1/24.
//

import Foundation
import SwiftUI

//Creamos un elemento de la List que nos permita mostrar los datos de una cerveza en una fila
struct BeerRow: View {
    var beer: Beer

    var body: some View {
        HStack {
            Image(beer.imageBeer)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(.trailing, 10)

            VStack(alignment: .leading) {
                Text(beer.type)
                Text(beer.name)
                    .font(.subheadline) // Tamaño de fuente menor
                    .foregroundColor(.gray) // Color más apagado
            }

            Spacer()

            
        }
    }
}


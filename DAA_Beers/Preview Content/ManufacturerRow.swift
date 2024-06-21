//
//  ManufacturerRow.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 21/1/24.
//

import Foundation
import SwiftUI

//Creamos un elemento de la List principal que nos permita mostrar los datos de un fabricante en una fila
struct ManufacturerRow: View {
    var manufacturer: Manufacturer

    var body: some View {
        HStack {
            Image(manufacturer.imageData)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(manufacturer.name)
            Spacer()
        }
    }
    
}


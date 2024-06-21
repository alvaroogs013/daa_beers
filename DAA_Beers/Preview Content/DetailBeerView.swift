//
//  DetailBeerView.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 27/1/24.
//

import Foundation
import SwiftUI

struct DetailBeerView: View {
    
    @Binding var beer: Beer

    @ObservedObject var viewModel: ManufacturerViewModel
    @State private var isEditBeerViewPresented = false

    var body: some View {
        VStack {
            // Mostrar la imagen de la cerveza
            Image(beer.imageBeer)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.trailing, 10)
            
            Text("Nombre: \(beer.name)")
            Text(String(format: "Graduación: %.1f", beer.graduation))
            Text("Calorías: \(String(beer.calories))")
            Text("Tipo: \(beer.type)")

            // Botón para modificar los datos
            Button(action: {
                isEditBeerViewPresented = true
            }) {
                Text("Editar Cerveza")
            }
            .sheet(isPresented: $isEditBeerViewPresented) {
                //Aquí presentas la vista para editar la cerveza
                EditBeerView(viewModel: viewModel, beer: $beer, onSave: { updatedBeer in
                    viewModel.updateBeer(updatedBeer)
                })

            }
        }
        .navigationBarTitle(beer.name)
    }
}

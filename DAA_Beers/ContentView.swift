//
//  ContentView.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 21/1/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ManufacturerViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Nacionales")) { //Creamos una seccion dentro de la List para los fabricantes Nacionales
                    let filteredNacionales = viewModel.manufacturers.filter { !$0.origin }
                    ForEach(filteredNacionales) { manufacturer in
                        NavigationLink(destination: DetailManufacturerView(manufacturer: manufacturer, listBeer: manufacturer.beers, viewModel: viewModel)) {
                            ManufacturerRow(manufacturer: manufacturer)
                        }
                    }
                    .onDelete { indexSet in
                        deleteManufacturer(at: indexSet, from: filteredNacionales)
                    }
                }

                Section(header: Text("Importados")) { //Creamos una seccion dentro de la List para los fabricantes importados
                    let filteredImportados = viewModel.manufacturers.filter { $0.origin }
                    ForEach(filteredImportados) { manufacturer in
                        NavigationLink(destination: DetailManufacturerView(manufacturer: manufacturer, listBeer: manufacturer.beers, viewModel: viewModel)) {
                            ManufacturerRow(manufacturer: manufacturer)
                        }
                    }
                    .onDelete { indexSet in //Llamamos a la funcion especifica para borrar el fabricante seleccionado
                        deleteManufacturer(at: indexSet, from: filteredImportados)
                    }
                }
            }
            .navigationBarItems(trailing: //Añadimos un boton de + en la barra de navegacion para abrir la vista para añadir un nuevo fabricante
                Button(action: {
                    viewModel.showAddManufacturerView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $viewModel.showAddManufacturerView) { //Mostramos la vista con el formulario para añadir un nuevo fabricante
                // Presenta AddManufacturerView
                AddManufacturerView(viewModel: viewModel, newManufacturerBeers: [])
            }
        }
    }


    private func deleteManufacturer(at indexSet: IndexSet, from filteredList: [Manufacturer]) {
        // Obtén los identificadores de los fabricantes que se van a eliminar
        let idsToDelete = indexSet.map { filteredList[$0].id }

        // Elimina los fabricantes basándote en los identificadores
        viewModel.manufacturers.removeAll(where: { idsToDelete.contains($0.id) })
    }
    
    func loadImageFromDocumentsDirectory(withFilename filename: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        return UIImage(contentsOfFile: fileURL.path)
    }


}

//
//  DetailManufacturerView.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 27/1/24.
//

import Foundation
import SwiftUI

struct DetailManufacturerView: View {
    var manufacturer: Manufacturer  // El fabricante actual.
    var listBeer: [Beer]  // Lista de cervezas asociadas con el fabricante.
    @ObservedObject var viewModel: ManufacturerViewModel  // ViewModel observado para cambios.

    // Estados de SwiftUI para manejar la lógica de UI.
    @State private var selectedBeer: Beer?  // Cerveza seleccionada actualmente.
    @State private var isSortActionSheetPresented = false  // Controla si se muestra la hoja de acciones de ordenación.
    @State private var selectedSortOption: SortOption = .name  // Opción de ordenación seleccionada.
    @State private var sortedList: [Beer] = []  // Lista de cervezas ordenadas.
    @State private var searchText = ""  // Texto de búsqueda para filtrar cervezas.

    // Enumeración para opciones de ordenación.
    enum SortOption {
        case name
        case graduation
        case calories
    }

    var body: some View {
        NavigationView {
            VStack {
                // Barra de búsqueda para filtrar cervezas.
                SearchBar(searchText: $searchText)
                
                // Lista de cervezas.
                List {
                    // Filtra y muestra las cervezas basándose en la búsqueda y la opción de ordenación.
                    ForEach(sortedList.filter { beer in
                        searchText.isEmpty ||
                        beer.name.localizedCaseInsensitiveContains(searchText) ||
                        beer.type.localizedCaseInsensitiveContains(searchText)
                    }, id: \.id) { beer in
                        // Botón para seleccionar una cerveza.
                        Button(action: {
                            self.selectedBeer = beer
                        }) {
                            BeerRow(beer: beer)
                        }
                    }
                    .onDelete(perform: deleteBeer)  // Permite eliminar cervezas.
                }
                .navigationBarTitle(manufacturer.name)
                .navigationBarItems(
                    leading: Button(action: {
                        viewModel.showAddBeerView = true  // Muestra la vista para añadir una cerveza.
                    }) {
                        Image(systemName: "plus")
                    },
                    trailing: Button(action: {
                        isSortActionSheetPresented = true  // Muestra las opciones de ordenación.
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                )
                .sheet(isPresented: $viewModel.showAddBeerView) {
                    AddBeerView(viewModel: viewModel, manufacturer: manufacturer)  // Vista para añadir una nueva cerveza.
                }
                .actionSheet(isPresented: $isSortActionSheetPresented) {
                    ActionSheet(
                        title: Text("Ordenar por"),
                        buttons: sortOptions()  // Botones para seleccionar la opción de ordenación.
                    )
                }
            }
            .onAppear {
                sortedList = listBeer
                sortBeers(by: selectedSortOption)  // Ordena las cervezas al aparecer la vista.
            }
        }
        .sheet(item: $selectedBeer) { selectedBeer in
            DetailBeerView(beer: Binding.constant(selectedBeer), viewModel: viewModel)  // Vista de detalles de una cerveza específica.
        }
    }

    func sortOptions() -> [ActionSheet.Button] {
        return [
            .default(Text("Nombre")) { sortBeers(by: .name) },
            .default(Text("Graduación")) { sortBeers(by: .graduation) },
            .default(Text("Calorías")) { sortBeers(by: .calories) },
            .cancel()
        ]
    }

    func sortBeers(by option: SortOption) {
        switch option {
        case .name:
            sortedList = listBeer.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        case .graduation:
            sortedList = listBeer.sorted { $0.graduation < $1.graduation }
        case .calories:
            sortedList = listBeer.sorted { $0.calories < $1.calories }
        }
    }

    func deleteBeer(at offsets: IndexSet) {
        // Encuentra las cervezas que serán eliminadas basándose en los offsets
        let beersToDelete = offsets.map { sortedList[$0] }

        // Elimina estas cervezas de la lista 'sortedList'
        sortedList.remove(atOffsets: offsets)

        // Encuentra el índice del fabricante actual en el viewModel
        if let manufacturerIndex = viewModel.manufacturers.firstIndex(where: { $0.id == manufacturer.id }) {
            // Elimina las cervezas de la lista de cervezas del fabricante en el viewModel
            viewModel.manufacturers[manufacturerIndex].beers.removeAll { beer in
                beersToDelete.contains(where: { $0.id == beer.id })
            }
        }
    }


}

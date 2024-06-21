//
//  ManufacturerViewModel.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 21/1/24.
//

import Foundation
import SwiftUI

class ManufacturerViewModel: ObservableObject {
    @Published var manufacturers: [Manufacturer] = []
    @Published var beers: [Beer] = []
    @Published var showAddManufacturerView = false
    @Published var showAddBeerView = false

    //Ejecutamos la funcion loadInitialData al lanzar la aplicación
    init() {
        loadInitialData()
    }
    
    //Funcion para cargar el conjunto inicial de datos desde un fichero JSON
    func loadInitialData() {
            if let url = Bundle.main.url(forResource: "InitialData", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    print(String(data: data, encoding: .utf8) ?? "Error al imprimir datos JSON")
                    let decodedData = try JSONDecoder().decode([Manufacturer].self, from: data)
                    manufacturers = decodedData
                    print("Manufacturers count after loading: \(manufacturers.count)")
                } catch {
                    print("Error loading initial data: \(error)")
                }
            }
        }

    // Función para agregar un nuevo fabricante
    func addManufacturer(_ manufacturer: Manufacturer) {
           if manufacturers.contains(where: { $0.id == manufacturer.id }) {
               // Si el fabricante ya existe, no lo agregamos nuevamente
               return
           }

           manufacturers.append(manufacturer)
       }
    
    //Funcion para guardar imagen en los assets del proyecto
    func saveImage(_ image: UIImage, forManufacturerWithID id: UUID, imageName: String) {
        if let index = manufacturers.firstIndex(where: { $0.id == id }) {
            // Guardar el nombre del archivo de imagen en lugar de los datos de la imagen
            manufacturers[index].imageData = imageName
        }
    }
    
    //Funcion para eliminar completamente un fabricante
    func deleteManufacturerAndBeers(at index: Int) {
            guard index < manufacturers.count else { return }
            manufacturers.remove(at: index)
        }
    
    //Funcion para añadir una cerveza a un fabricante seleccionado
    func addBeer(_ beer: Beer, toManufacturerWithID manufacturerID: UUID) {
            if let index = manufacturers.firstIndex(where: { $0.id == manufacturerID }) {
                manufacturers[index].beers.append(beer)
            }
        }
    
    //Funcion para actualizar los datos de una cerveza de un fabricante
    func updateBeer(_ updatedBeer: Beer) {
        for i in 0..<manufacturers.count {
            if let beerIndex = manufacturers[i].beers.firstIndex(where: { $0.id == updatedBeer.id }) {
                manufacturers[i].beers[beerIndex] = updatedBeer
                break
            }
        }
    }

}


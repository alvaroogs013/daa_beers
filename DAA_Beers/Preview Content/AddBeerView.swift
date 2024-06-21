//
//  AddBeerView.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 28/1/24.
//

import Foundation
import SwiftUI

struct AddBeerView: View {
    @ObservedObject var viewModel: ManufacturerViewModel  // ViewModel que maneja la lógica de negocio.
    var manufacturer: Manufacturer  // El fabricante al que se añadirá la nueva cerveza.

    // Estados de SwiftUI para manejar la entrada de datos y la lógica de la interfaz de usuario.
    @State private var newBeerName = ""  // Nombre de la nueva cerveza.
    @State private var newBeerGraduation = 5.0  // Graduación alcohólica de la nueva cerveza.
    @State private var newBeerCalories = 150  // Calorías de la nueva cerveza.
    @State private var newBeerType = ""  // Tipo de la nueva cerveza.
    @State private var selectedBeerImage: UIImage? = nil  // Imagen seleccionada para la nueva cerveza.
    @State private var isImagePickerPresented: Bool = false  // Controla la presentación del selector de imágenes.
    
    @Environment(\.presentationMode) var presentationMode  // Maneja la presentación de la vista actual.

    var body: some View {
        Form {
            Section {
                // Campo de texto para el nombre de la cerveza.
                TextField("Nombre de la cerveza", text: $newBeerName)
                // Campo de texto para el tipo de cerveza.
                TextField("Tipo", text: $newBeerType)
                // Stepper para la graduación alcohólica de la cerveza.
                Stepper(value: $newBeerGraduation, in: 0.0...20.0, step: 0.1) {
                    Text("Graduación: \(String(format: "%.1f", newBeerGraduation))%")
                }
                // Stepper para las calorías de la cerveza.
                Stepper(value: $newBeerCalories, in: 0...500) {
                    Text("Calorías: \(newBeerCalories)")
                }
            }

            Section {
                // Botón para seleccionar una imagen de la cerveza.
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("Seleccionar imagen")
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $selectedBeerImage)  // Selector de imágenes.
                }

                // Muestra la imagen seleccionada si está disponible.
                if let selectedBeerImage = selectedBeerImage {
                    Image(uiImage: selectedBeerImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding(.vertical, 10)
                }
            }

            Section {
                // Botón para añadir la nueva cerveza.
                Button(action: {
                    addBeer()  // Llama a la función para añadir una cerveza.
                    viewModel.showAddBeerView = false  // Cierra la vista.
                }) {
                    Text("Añadir Cerveza")
                }
            }
        }
        .navigationTitle("Nueva Cerveza")
    }

    // Función para añadir una nueva cerveza.
    func addBeer() {
        // Verifica que el nombre de la cerveza no esté vacío.
        guard !newBeerName.isEmpty else { return }
        let imageName = UUID().uuidString  // Genera un identificador único para la imagen.

        // Crea un nuevo objeto Beer.
        let newBeer = Beer(
            name: newBeerName,
            imageBeer: imageName,  // Asigna el identificador de la imagen.
            graduation: newBeerGraduation,
            calories: newBeerCalories,
            type: newBeerType
        )
                
        // Añade la nueva cerveza al viewModel.
        viewModel.addBeer(newBeer, toManufacturerWithID: manufacturer.id)
    }
}


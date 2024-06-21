//
//  AddManufacturerView.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 21/1/24.
//

import Foundation
import SwiftUI

//Vista para añadir un nuevo fabricante

struct AddManufacturerView: View {
    @ObservedObject var viewModel: ManufacturerViewModel  // ViewModel que maneja la lógica de negocio.
    @State private var newManufacturerName = ""  // Nombre del nuevo fabricante.
    @State private var newManufacturerIsImported = false  // Indica si el fabricante es importado.
    @State private var selectedImage: UIImage? = nil  // Imagen seleccionada para el fabricante.
    @State private var isImagePickerPresented: Bool = false  // Controla la presentación del selector de imágenes.
    var newManufacturerBeers: [Beer]  // Cervezas asociadas con el nuevo fabricante.

    @Environment(\.presentationMode) var presentationMode  // Maneja la presentación de la vista actual.

    var body: some View {
        Form {
            Section {
                // Campo de texto para el nombre del fabricante.
                TextField("Nombre del fabricante", text: $newManufacturerName)
                // Toggle para marcar si el fabricante es importado.
                Toggle("Importado", isOn: $newManufacturerIsImported)
            }

            Section {
                // Botón para seleccionar una imagen.
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("Seleccionar imagen")
                }
                // Presenta el ImagePicker cuando isImagePickerPresented es true.
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $selectedImage)
                }

                // Muestra la imagen seleccionada si está disponible.
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding(.vertical, 10)
                }
            }

            Section {
                // Botón para añadir un nuevo fabricante.
                Button(action: {
                    addManufacturer()  // Llama a la función para añadir un fabricante.
                    viewModel.showAddManufacturerView = false  // Cierra la vista.
                }) {
                    Text("Añadir fabricante")
                }
            }
        }
        // Configuración de la barra de navegación.
        .navigationTitle("Nuevo Fabricante")
    }

    // Función para añadir un nuevo fabricante.
    func addManufacturer() {
        // Verifica que el nombre del fabricante no esté vacío.
        guard !newManufacturerName.isEmpty else { return }
        let imageName = UUID().uuidString  // Genera un identificador único para la imagen.

        // Crea un nuevo objeto Manufacturer.
        let newManufacturer = Manufacturer(
            name: newManufacturerName,
            imageData: imageName,
            origin: newManufacturerIsImported,
            beers: []
        )

        // Añade el nuevo fabricante al viewModel.
        viewModel.addManufacturer(newManufacturer)
    }
}


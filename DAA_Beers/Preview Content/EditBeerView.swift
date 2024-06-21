//
//  EditBeerView.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 29/1/24.
//

import Foundation
import SwiftUI

struct EditBeerView: View {
    @Binding var beer: Beer  // Binding a la cerveza que se está editando.
    @ObservedObject var viewModel: ManufacturerViewModel  // ViewModel para manejar operaciones de datos.
    var onSave: (Beer) -> Void  // Closure que se ejecuta al guardar los cambios.

    @State private var editedBeer: Beer  // Estado local para manejar la edición de la cerveza.
    @State private var selectedImage: UIImage?  // Imagen seleccionada para la cerveza.
    @State private var isImagePickerPresented = false  // Controla la presentación del selector de imágenes.
    @Environment(\.presentationMode) var presentationMode  // Maneja la presentación de la vista actual.

    // Inicializador para configurar los valores iniciales.
    init(viewModel: ManufacturerViewModel, beer: Binding<Beer>, onSave: @escaping (Beer) -> Void) {
        self.viewModel = viewModel
        self._beer = beer
        self.onSave = onSave
        _editedBeer = State(initialValue: beer.wrappedValue)
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Detalles de la cerveza")) {
                        // Campos para editar los detalles de la cerveza.
                        TextField("Nombre", text: $editedBeer.name)
                        TextField("Tipo", text: $editedBeer.type)
                        TextField("Calorías", value: $editedBeer.calories, formatter: NumberFormatter())
                        NumericField(title: "Graduación", value: $editedBeer.graduation)
                    }

                    Section(header: Text("Imagen")) {
                        // Botón para seleccionar una nueva imagen.
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Text("Seleccionar imagen")
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(image: $selectedImage)  // Selector de imágenes.
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
                        // Botón para guardar los cambios.
                        Button("Guardar") {
                            viewModel.updateBeer(editedBeer)
                            presentationMode.wrappedValue.dismiss()
                        }
                        // Botón para cancelar y cerrar la vista.
                        Button("Cancelar"){
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .navigationBarTitle("Editar Cerveza")
                .padding()
            }
        }
        .onDisappear {
            // Limpiar los campos al salir de la vista
            editedBeer = Beer(name: "", imageBeer: "", graduation: 0, calories: 0, type: "")
            selectedImage = nil
        }
    }
}

// Vista auxiliar para un campo numérico.
struct NumericField: View {
    let title: String
    @Binding var value: Double

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", value: $value, formatter: NumberFormatter())
        }
    }
}

//
//  SearchBar.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 27/1/24.
//

import Foundation
import SwiftUI

//Creamos la barra de búsqueda de la vista DetailManufacturerView
struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Buscar", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(8)
                }
                .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}


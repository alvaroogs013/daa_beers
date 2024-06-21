//
//  DAA_BeersApp.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 21/1/24.
//

import SwiftUI

@main
struct DAA_BeersApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ManufacturerViewModel()  // Crea una instancia de ManufacturerViewModel
            ContentView(viewModel: viewModel)  // Pasa el viewModel a ContentView
        }
    }
}

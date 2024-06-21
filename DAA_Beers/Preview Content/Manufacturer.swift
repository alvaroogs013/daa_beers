//
//  Manufacturer.swift
//  DAA_Beers
//
//  Created by Alvaro Garcia on 21/1/24.
//

import Foundation

//Modelo de datos de fabricante
struct Manufacturer: Identifiable, Codable {
    let id = UUID()
    var name: String
    var imageData: String
    var origin: Bool
    var beers: [Beer]
}

//Modelo de datos de cerveza
struct Beer: Identifiable, Hashable, Codable {
    let id = UUID()
    var name: String
    var imageBeer: String
    var graduation: Double
    var calories: Int
    var type: String
}

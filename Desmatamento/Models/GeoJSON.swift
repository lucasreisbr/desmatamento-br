//
//  GeoJSON.swift
//  Desmatamento
//
//  Created by Lucas Reis on 25/08/26.
//
import Foundation
import CoreLocation

struct FeatureCollection: Decodable {
    let features: [Feature]
}

struct Feature: Decodable {
    let geometry: Geometria
    let properties: Propriedades
}

struct Propriedades: Decodable {
    let state: String?
    let year: Int?
    let areaKm: Double?

    enum CodingKeys: String, CodingKey {
        case state, year
        case areaKm = "area_km"
    }
}

struct Geometria: Decodable {
    let type: String
    let coordinates: [[[[Double]]]]

    /// Extrai só o anel externo de cada polígono (ignora buracos internos),
    /// já convertendo pra CLLocationCoordinate2D (invertendo lon/lat).
    var aneisExternos: [[CLLocationCoordinate2D]] {
        coordinates.map { poligono in
            guard let anelExterno = poligono.first else { return [] }
            return anelExterno.map { ponto in
                CLLocationCoordinate2D(latitude: ponto[1], longitude: ponto[0])
            }
        }
    }
}

struct PoligonoDesmatamento: Identifiable {
    let id = UUID()
    let bioma: Bioma
    let coordenadas: [CLLocationCoordinate2D]
    let estado: String?
    let ano: Int?
    let areaKm: Double?
}

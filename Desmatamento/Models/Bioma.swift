import SwiftUI

/// Representa os 6 biomas brasileiros monitorados pelo PRODES/INPE.
/// Praticando: enum com raw value, conformance a múltiplos protocols,
/// e propriedades computadas (switch exaustivo — o compilador te avisa
/// se esquecer um case, diferente de um dict em Python).
enum Bioma: String, CaseIterable, Identifiable, Codable {
    case amazonia = "Amazônia"
    case cerrado = "Cerrado"
    case mataAtlantica = "Mata Atlântica"
    case caatinga = "Caatinga"
    case pantanal = "Pantanal"
    case pampa = "Pampa"

    // Identifiable exige uma propriedade `id`. Como o rawValue já é
    // único, reaproveitamos em vez de gerar um UUID à toa.
    var id: String { rawValue }

    var corRepresentativa: Color {
        switch self {
        case .amazonia: return .green
        case .cerrado: return .orange
        case .mataAtlantica: return .mint
        case .caatinga: return .brown
        case .pantanal: return .cyan
        case .pampa: return .yellow
        }
    }

    var descricaoCurta: String {
        switch self {
        case .amazonia: return "Maior floresta tropical do mundo"
        case .cerrado: return "Savana mais biodiversa do planeta"
        case .mataAtlantica: return "Um dos biomas mais ameaçados do Brasil"
        case .caatinga: return "Único bioma exclusivamente brasileiro"
        case .pantanal: return "Maior planície alagável do mundo"
        case .pampa: return "Campos e coxilhas do extremo sul"
        }
    }
}

import Foundation

/// Valores ILUSTRATIVOS, só para termos algo na tela enquanto praticamos
/// SwiftUI nas Semanas 0-1. Na Semana 2 isso é substituído por dados
/// reais baixados do TerraBrasilis (PRODES/DETER).
enum MockData {
    static let taxasRecentes: [TaxaDesmatamento] = [
        TaxaDesmatamento(bioma: .amazonia, ano: 2024, areaKm2: 6288),
        TaxaDesmatamento(bioma: .cerrado, ano: 2024, areaKm2: 6392),
        TaxaDesmatamento(bioma: .mataAtlantica, ano: 2024, areaKm2: 187),
        TaxaDesmatamento(bioma: .caatinga, ano: 2024, areaKm2: 411),
        TaxaDesmatamento(bioma: .pantanal, ano: 2024, areaKm2: 52),
        TaxaDesmatamento(bioma: .pampa, ano: 2024, areaKm2: 33),
    ]

    /// Histórico multi-ano só do bioma Amazônia, útil quando chegarmos
    /// nos gráficos (Swift Charts) na Semana 2.
    static let historicoAmazonia: [TaxaDesmatamento] = [
        TaxaDesmatamento(bioma: .amazonia, ano: 2020, areaKm2: 10851),
        TaxaDesmatamento(bioma: .amazonia, ano: 2021, areaKm2: 13038),
        TaxaDesmatamento(bioma: .amazonia, ano: 2022, areaKm2: 11594),
        TaxaDesmatamento(bioma: .amazonia, ano: 2023, areaKm2: 9001),
        TaxaDesmatamento(bioma: .amazonia, ano: 2024, areaKm2: 6288),
    ]
}

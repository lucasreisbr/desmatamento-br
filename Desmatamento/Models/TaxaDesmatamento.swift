import Foundation

/// Um ponto de dado: área desmatada de um bioma em um ano específico.
/// Struct (value type) porque isso é um dado imutável que só carregamos
/// e exibimos — não precisamos de identidade de referência (class) aqui.
struct TaxaDesmatamento: Identifiable, Codable, Hashable {
    let id: UUID
    let bioma: Bioma
    let ano: Int
    let areaKm2: Double

    // Inicializador customizado: geramos o UUID automaticamente para
    // dado mockado, mas ainda permitimos Codable decodificar de JSON
    // real (onde o `id` pode não vir no payload — trataremos isso
    // na Semana 2 com CodingKeys).
    init(id: UUID = UUID(), bioma: Bioma, ano: Int, areaKm2: Double) {
        self.id = id
        self.bioma = bioma
        self.ano = ano
        self.areaKm2 = areaKm2
    }
}

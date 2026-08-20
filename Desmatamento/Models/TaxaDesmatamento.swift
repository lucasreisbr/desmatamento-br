import Foundation

struct TaxaDesmatamento: Identifiable, Codable, Hashable {
    let id: UUID
    let bioma: Bioma
    let ano: Int
    let areaKm2: Double

    init(id: UUID = UUID(), bioma: Bioma, ano: Int, areaKm2: Double) {
        self.id = id
        self.bioma = bioma
        self.ano = ano
        self.areaKm2 = areaKm2
    }

    // Diz ao Codable pra NÃO esperar "id" no JSON
    enum CodingKeys: String, CodingKey {
        case bioma, ano, areaKm2
    }

    // Decoder customizado: gera um UUID novo pra cada item decodificado,
    // já que o JSON não traz id nenhum.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.bioma = try container.decode(Bioma.self, forKey: .bioma)
        self.ano = try container.decode(Int.self, forKey: .ano)
        self.areaKm2 = try container.decode(Double.self, forKey: .areaKm2)
    }
}

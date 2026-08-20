//
//  FiltroViewModel.swift
//  Desmatamento
//
//  Created by Lucas Reis on 19/08/26.
//

import Foundation
import Observation

@Observable
class FiltroViewModel {
    enum EstadoTela {
        case carregando
        case carregado
        case erro(String)
    }

    var busca: String = ""
    var taxas: [TaxaDesmatamento] = []
    var estado: EstadoTela = .carregando

    private let urlTaxas = "https://raw.githubusercontent.com/lucasreisbr/desmatamento-br/refs/heads/main/taxas.json"

    var taxasFiltradas: [TaxaDesmatamento] {
        busca.isEmpty ? taxas : taxas.filter {
            $0.bioma.rawValue.localizedCaseInsensitiveContains(busca)
        }
    }
    
    var historico: [TaxaDesmatamento] = []

    private let urlHistorico = "https://raw.githubusercontent.com/lucasreisbr/desmatamento-br/refs/heads/main/historico.json"

    func carregarHistorico() async {
        do {
            historico = try await buscarJSON(de: urlHistorico, tipo: [TaxaDesmatamento].self)
        } catch {
            print("Erro ao carregar histórico: \(error)")
        }
    }

    func carregar() async {
        estado = .carregando
        do {
            taxas = try await buscarJSON(de: urlTaxas, tipo: [TaxaDesmatamento].self)
            estado = .carregado
        } catch {
            estado = .erro(error.localizedDescription)
        }
    }
}

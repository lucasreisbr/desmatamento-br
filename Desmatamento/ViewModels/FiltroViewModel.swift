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
    var busca: String = ""
    var taxas: [TaxaDesmatamento] = MockData.taxasRecentes

    var taxasFiltradas: [TaxaDesmatamento] {
        busca.isEmpty ? taxas : taxas.filter {
            $0.bioma.rawValue.localizedCaseInsensitiveContains(busca)
        }
    }
}

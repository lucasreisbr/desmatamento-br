//
//  RedeService.swift
//  Desmatamento
//
//  Created by Lucas Reis on 20/08/26.
//
import Foundation

enum ErroRede: Error, LocalizedError {
    case urlInvalida
    case respostaInvalida
    case falhaDecodificacao

    var errorDescription: String? {
        switch self {
        case .urlInvalida: return "URL inválida"
        case .respostaInvalida: return "Resposta do servidor inválida"
        case .falhaDecodificacao: return "Não foi possível ler os dados"
        }
    }
}

func buscarJSON<T: Decodable>(de urlString: String, tipo: T.Type) async throws -> T {
    guard let url = URL(string: urlString) else {
        throw ErroRede.urlInvalida
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse,
          200...299 ~= httpResponse.statusCode else {
        throw ErroRede.respostaInvalida
    }

    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        throw ErroRede.falhaDecodificacao
    }
}

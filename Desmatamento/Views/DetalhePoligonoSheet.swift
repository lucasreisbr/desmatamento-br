//
//  DetalhePoligonoSheet.swift
//  Desmatamento
//
//  Created by Lucas Reis on 01/09/26.
//

import SwiftUI

struct DetalhePoligonoSheet: View {
    let poligono: PoligonoDesmatamento

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .fill(poligono.bioma.corRepresentativa)
                    .frame(width: 16, height: 16)
                Text(poligono.bioma.rawValue)
                    .font(.title2.bold())
            }

            if let estado = poligono.estado {
                HStack {
                    Text("Estado")
                    Spacer()
                    Text(estado.capitalized)
                        .fontWeight(.semibold)
                }
            }

            if let ano = poligono.ano {
                HStack {
                    Text("Ano")
                    Spacer()
                    Text("\(ano)")
                        .fontWeight(.semibold)
                }
            }

            if let area = poligono.areaKm {
                HStack {
                    Text("Área da mancha")
                    Spacer()
                    Text(String(format: "%.2f km²", area))
                        .fontWeight(.semibold)
                }
            }

            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
}

#Preview {
    DetalhePoligonoSheet(
        poligono: PoligonoDesmatamento(
            bioma: .cerrado,
            coordenadas: [],
            estado: "GOIÁS",
            ano: 2023,
            areaKm: 1.42
        )
    )
}

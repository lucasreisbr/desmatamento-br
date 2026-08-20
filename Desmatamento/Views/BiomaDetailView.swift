import SwiftUI
import Charts

struct BiomaDetailView: View {
    let taxa: TaxaDesmatamento
    let viewModel: FiltroViewModel

    private var historicoDoBioma: [TaxaDesmatamento] {
        viewModel.historico
            .filter { $0.bioma == taxa.bioma }
            .sorted { $0.ano < $1.ano }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Circle()
                .fill(taxa.bioma.corRepresentativa)
                .frame(width: 60, height: 60)

            Text(taxa.bioma.rawValue)
                .font(.largeTitle.bold())

            Text(taxa.bioma.descricaoCurta)
                .foregroundStyle(.secondary)

            Divider()

            HStack {
                Text("Ano de referência")
                Spacer()
                Text("\(taxa.ano)")
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Área desmatada")
                Spacer()
                Text("\(Int(taxa.areaKm2)) km²")
                    .fontWeight(.semibold)
            }

            Spacer()

            if historicoDoBioma.isEmpty {
                ProgressView("Carregando histórico...")
            } else {
                Chart(historicoDoBioma) { ponto in
                    BarMark(
                        x: .value("Ano", String(ponto.ano)),
                        y: .value("Área", ponto.areaKm2)
                    )
                    .foregroundStyle(taxa.bioma.corRepresentativa)
                }
                .frame(height: 180)
            }
        }
        .padding()
        .navigationTitle(taxa.bioma.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.carregarHistorico()
        }
    }
}

#Preview {
    NavigationStack {
        BiomaDetailView(taxa: MockData.taxasRecentes[0], viewModel: FiltroViewModel())
    }
}

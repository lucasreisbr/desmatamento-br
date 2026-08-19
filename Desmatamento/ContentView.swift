import SwiftUI

struct ContentView: View {
    @State private var viewModel = FiltroViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.taxasFiltradas.isEmpty {
                    ContentUnavailableView(
                        "Nenhum bioma encontrado",
                        systemImage: "leaf.fill",
                        description: Text("Tente buscar por \"Amazônia\" ou \"Cerrado\".")
                    )
                } else {
                    List(viewModel.taxasFiltradas) { taxa in
                        NavigationLink(value: taxa) {
                            linha(para: taxa)
                        }
                    }
                }
            }
            .navigationDestination(for: TaxaDesmatamento.self) { taxa in
                BiomaDetailView(taxa: taxa)
            }
            .searchable(text: $viewModel.busca, prompt: "Buscar bioma...")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desmatamento")
                        Text("no Brasil")
                    }
                    .font(.largeTitle)
                    .padding(.top, 30)
                }
            }
        }
    }

    @ViewBuilder
    private func linha(para taxa: TaxaDesmatamento) -> some View {
        HStack {
            Circle()
                .fill(taxa.bioma.corRepresentativa)
                .frame(width: 12, height: 12)

            VStack(alignment: .leading) {
                Text(taxa.bioma.rawValue)
                    .font(.headline)
                Text(taxa.bioma.descricaoCurta)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("\(Int(taxa.areaKm2)) km²")
                .font(.subheadline.monospacedDigit())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}

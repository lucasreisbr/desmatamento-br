import SwiftUI

struct BiomaDetailView: View {
    let taxa: TaxaDesmatamento

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

            // Placeholder: na Semana 2 entra um gráfico (Swift Charts)
            // com o histórico multi-ano deste bioma, usando
            // MockData.historicoAmazonia como referência de formato.
            Text("📈 Gráfico de evolução histórica entra aqui na Semana 2")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .navigationTitle(taxa.bioma.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BiomaDetailView(taxa: MockData.taxasRecentes[0])
    }
}

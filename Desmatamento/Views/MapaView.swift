import SwiftUI
import MapKit

struct MapaView: View {
    @State private var posicaoCamera: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -14.2350, longitude: -51.9253),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
    )
    @State private var poligonos: [PoligonoDesmatamento] = []
    @State private var poligonoSelecionado: PoligonoDesmatamento?

    var body: some View {
        MapReader { proxy in
            Map(position: $posicaoCamera) {
                Marker("Amazônia", coordinate: CLLocationCoordinate2D(latitude: -3.4, longitude: -62.2))
                    .tint(.green)
                Marker("Cerrado", coordinate: CLLocationCoordinate2D(latitude: -15.6, longitude: -47.8))
                    .tint(.orange)
                Marker("Pantanal", coordinate: CLLocationCoordinate2D(latitude: -17.6, longitude: -57.5))
                    .tint(.cyan)
                Marker("Mata Atlântica", coordinate: CLLocationCoordinate2D(latitude: -20.6, longitude: -46.5))
                    .tint(.purple)
                Marker("Caatinga", coordinate: CLLocationCoordinate2D(latitude: -9.4, longitude: -40.5))
                    .tint(.brown)
                Marker("Pampa", coordinate: CLLocationCoordinate2D(latitude: -30.5, longitude: -53.5))
                    .tint(.yellow)

                ForEach(poligonos) { item in
                    MapPolygon(coordinates: item.coordenadas)
                        .foregroundStyle(item.bioma.corRepresentativa.opacity(0.5))
                        .stroke(item.bioma.corRepresentativa, lineWidth: 1)
                }
            }
            .mapStyle(.standard)
            .task {
                await carregarTodosBiomas()
            }
            .gesture(
                SpatialTapGesture().onEnded { valor in
                    guard let coordenada = proxy.convert(valor.location, from: .local) else { return }
                    poligonoSelecionado = poligono(contendo: coordenada)
                }
            )
        }
        .sheet(item: $poligonoSelecionado) { poligono in
            DetalhePoligonoSheet(poligono: poligono)
        }
    }

    private func carregarTodosBiomas() async {
        await withTaskGroup(of: [PoligonoDesmatamento].self) { grupo in
            for bioma in Bioma.allCases {
                grupo.addTask {
                    await buscarPoligonos(doBioma: bioma)
                }
            }
            var resultado: [PoligonoDesmatamento] = []
            for await parcial in grupo {
                resultado.append(contentsOf: parcial)
            }
            poligonos = resultado
        }
    }

    private func buscarPoligonos(doBioma bioma: Bioma) async -> [PoligonoDesmatamento] {
        let url = "https://terrabrasilis.dpi.inpe.br/geoserver/wfs?service=WFS&version=2.0.0&request=GetFeature&typeName=\(bioma.typeNameWFS)&outputFormat=application/json&CQL_FILTER=year=2012&count=600"
        do {
            let dado = try await buscarJSON(de: url, tipo: FeatureCollection.self)
            return dado.features.flatMap { feature in
                feature.geometry.aneisExternos.map { anel in
                    PoligonoDesmatamento(
                        bioma: bioma,
                        coordenadas: anel,
                        estado: feature.properties.state,
                        ano: feature.properties.year,
                        areaKm: feature.properties.areaKm
                    )
                }
            }
        } catch {
            print("Erro ao carregar \(bioma.rawValue): \(error)")
            return []
        }
    }

    // Encontra qual polígono (se algum) contém a coordenada tocada
    private func poligono(contendo coordenada: CLLocationCoordinate2D) -> PoligonoDesmatamento? {
        poligonos.first { pontoDentroDoPoligono(coordenada, $0.coordenadas) }
    }

    // Algoritmo clássico "ray casting": traça uma linha imaginária a partir
    // do ponto e conta quantas vezes ela cruza as bordas do polígono.
    // Número ímpar de cruzamentos = ponto está dentro.
    private func pontoDentroDoPoligono(_ ponto: CLLocationCoordinate2D, _ poligono: [CLLocationCoordinate2D]) -> Bool {
        guard poligono.count > 2 else { return false }
        var dentro = false
        var j = poligono.count - 1
        for i in 0..<poligono.count {
            let pi = poligono[i]
            let pj = poligono[j]
            if (pi.latitude > ponto.latitude) != (pj.latitude > ponto.latitude),
               ponto.longitude < (pj.longitude - pi.longitude) * (ponto.latitude - pi.latitude) / (pj.latitude - pi.latitude) + pi.longitude {
                dentro.toggle()
            }
            j = i
        }
        return dentro
    }
}

#Preview {
    MapaView()
}

//
//  RootView.swift
//  Desmatamento
//
//  Created by Lucas Reis on 25/08/26.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Lista", systemImage: "list.bullet")
                }

            MapaView()
                .tabItem {
                    Label("Mapa", systemImage: "map")
                }
        }
    }
}

#Preview {
    RootView()
}

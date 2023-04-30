//
//  RouteView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI

struct IdentifiableStep: Identifiable {
    var id: UUID = UUID()
    var destination: String
}

struct RouteDetailView: View {
    var stepsArray = [
        IdentifiableStep(destination: "Primer paso"),
        IdentifiableStep(destination: "Segundo paso"),
        IdentifiableStep(destination: "Tercer paso"),
    ]
    
    var ruta: String
    
    init(_ ruta: String) {
        self.ruta = ruta
    }
    
    var body: some View {
        List(stepsArray) { step in
            Text(step.destination)
        }
        .navigationTitle(ruta)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RouteView: View {
    var routeArray = [
        IdentifiableRoute(name: "Ruta 1", from: "Mixcoac", to: "Universidad"),
        IdentifiableRoute(name: "Ruta 2", from: "Mixcoac", to: "Universidad"),
        IdentifiableRoute(name: "Ruta 3", from: "Mixcoac", to: "Universidad")
    ]
    
    var body: some View {
        NavigationView {
            List(routeArray) { route in
                NavigationLink(destination: { RouteDetailView(route.name) }) {
                    HStack {
                        Text(route.name)
                        Text("\(route.from) - \(route.to)")
                    }
                }
            }
            .navigationTitle("Rutas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
    }
}

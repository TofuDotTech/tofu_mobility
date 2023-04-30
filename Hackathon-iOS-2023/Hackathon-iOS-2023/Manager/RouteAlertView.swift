//
//  RouteAlertView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI

struct RouteAlertView: View {
    var routeArray = [
        IdentifiableRoute(name: "Ruta 1", from: "Mixcoac", to: "Universidad"),
        IdentifiableRoute(name: "Ruta 2", from: "Mixcoac", to: "Universidad"),
        IdentifiableRoute(name: "Ruta 3", from: "Mixcoac", to: "Universidad")
    ]
    
    var body: some View {
        NavigationView {
            List(routeArray) { route in
                NavigationLink(destination: { Text("h1") }) {
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

struct RouteAlertView_Previews: PreviewProvider {
    static var previews: some View {
        RouteAlertView()
    }
}

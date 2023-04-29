//
//  ContentView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let manager = CLLocationManager()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "CoolGray")
    }
    
    var body: some View {
        TabView {
            /* MapTestView(
                latitude: manager.location?.coordinate.latitude.magnitude ?? 0.0,
                longitude: manager.location?.coordinate.longitude.magnitude ?? 0.0
                )
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                } */
            MainView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
            
            RouteView()
                .tabItem {
                    Label("Rutas", systemImage: "bus.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

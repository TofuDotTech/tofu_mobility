//
//  ContentView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var network: Network
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "CoolGray")
    }
    
    var body: some View {
        LoginView()
            .environmentObject(network)
    }
}

struct Passenger: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        TabView {
            PassengerMainView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
                .environmentObject(network)
            
            RouteView()
                .tabItem {
                    Label("Rutas", systemImage: "bus.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}

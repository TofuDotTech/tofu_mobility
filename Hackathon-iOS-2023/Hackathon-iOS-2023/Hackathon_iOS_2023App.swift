//
//  Hackathon_iOS_2023App.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI

@main
struct Hackathon_iOS_2023App: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
                .preferredColorScheme(.dark)
        }
    }
}

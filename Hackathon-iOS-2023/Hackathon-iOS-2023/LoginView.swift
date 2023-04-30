//
//  LoginView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 30/04/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Elige el plan al que perteneces:")
                    .font(.title)
                NavigationLink(
                    destination: Passenger()
                        .onAppear{network.getInCurrentRoute()}
                        .environmentObject(network)
                ) {
                    Text("Pasajero")
                }
                .buttonStyle(.borderedProminent)
                NavigationLink(destination: PrincipalConductor()) {
                    Text("Conductor")
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .navigationTitle("¡Bienvenido!")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

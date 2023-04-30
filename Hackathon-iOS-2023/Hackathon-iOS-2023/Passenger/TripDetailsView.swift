//
//  TripDetailsView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI

struct TripDetailsItem: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.body).foregroundColor(.gray)
                Text(value).font(.title2)
            }
            Spacer()
        }
    }
}

struct TripDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TripDetailsItem(title: "Fecha", value: "Martes, 31 de abril de 2023")
            TripDetailsItem(title: "Duración", value: "40 min")
            TripDetailsItem(title: "Hora Inicio", value: "10:30 AM")
            TripDetailsItem(title: "Hora Finalización", value: "10:50 AM")
            TripDetailsItem(title: "Conductor", value: "Jose Luis Mendez")
            TripDetailsItem(title: "Placas de camión", value: "A00 AAA")
            TripDetailsItem(title: "Parada de inicio", value: "Donatello 43")
            TripDetailsItem(title: "Parada de bajada", value: "Universidad 90")
            Spacer()
            Button(action: {}) {
                Spacer()
                Text("Reportar viaje")
                    .font(.title2)
                Spacer()
            }
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .tint(Color("CoolRed"))
        }
        .padding(EdgeInsets(top: 8, leading: 12, bottom: 12, trailing: 12))
        .navigationTitle("Detalles del viaje")
    }
}

struct TripDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailsView()
    }
}

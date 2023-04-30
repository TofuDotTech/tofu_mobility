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

struct IdentifiableSelectable: Identifiable {
    var id: UUID = UUID()
    var value: String
    
    init(_ value: String) {
        self.value = value
    }
}

struct BottomDrawer: View {
    var selectables = [
        IdentifiableSelectable("Asalto"),
        IdentifiableSelectable("El conductor se peleó"),
        IdentifiableSelectable("El conductor manejaba ebrio"),
    ]
    @State var selected: String = ""
    var onReportClick: () -> Void
    
    init(onReportClick: @escaping () -> Void) {
        self.onReportClick = onReportClick
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("¿Qué quieres reportar").font(.body)
            ForEach(selectables) { selectable in
                Button(action: { selected = selectable.value }) {
                    HStack {
                        if selected == selectable.value {
                            Image(systemName: "circle.fill")
                        }
                        else {
                            Image(systemName: "circle")
                        }
                        Text(selectable.value)
                    }.foregroundColor(.white)
                }
            }
            RedButton("Reportar viaje") { onReportClick() }
        }
        .padding()
        .background(Color("CoolGray"))
        .cornerRadius(20)
    }
}

struct TripDetailsView: View {
    @State var showDrawer: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
                RedButton("Reportar viaje") {
                    withAnimation {
                        showDrawer = true
                    }
                }
            }
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            if showDrawer {
                BottomDrawer {
                    withAnimation {
                        showDrawer = false
                    }
                }
                .padding(.bottom, 8)
            }
        }
        .navigationTitle("Detalles del viaje")
    }
}

struct TripDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailsView()
    }
}

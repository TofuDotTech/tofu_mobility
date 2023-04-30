//
//  TripsView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI

struct IdentifiableTrip: Identifiable {
    var id: UUID = UUID()
    var date: String
    var duration: Int
    var driver: String
}

struct TripsView: View {
    let arrayTrips = [
        IdentifiableTrip(
            date: "Abr 31",
            duration: 40,
            driver: "José Jury Hernandez"
        ),
        IdentifiableTrip(
            date: "Abr 31",
            duration: 40,
            driver: "José Jury Hernandez"
        ),
        IdentifiableTrip(
            date: "Abr 31",
            duration: 40,
            driver: "José Jury Hernandez"
        ),
        IdentifiableTrip(
            date: "Abr 31",
            duration: 40,
            driver: "José Jury Hernandez"
        ),
        IdentifiableTrip(
            date: "Abr 31",
            duration: 40,
            driver: "José Jury Hernandez"
        ),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus viajes")
                .frame(height: 50)
            ZStack {
                HStack {
                    Text("Fecha")
                    Spacer()
                    Text("Duración")
                }
                Text("Conductor")
            }
            .padding(.bottom, 8)
            ForEach(arrayTrips) { trip in
                NavigationLink(destination: TripDetailsView()) {
                    ZStack(alignment: .center) {
                        HStack {
                            Text(trip.date)
                            Spacer()
                            Text(String(trip.duration))
                        }
                        Text(trip.driver)
                    }
                    .foregroundColor(.white)
                }
                Divider()
            }
            Spacer()
        }
        .navigationTitle("Juary Lecona Valdespino")
        .navigationBarTitleDisplayMode(.inline)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 8))
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}

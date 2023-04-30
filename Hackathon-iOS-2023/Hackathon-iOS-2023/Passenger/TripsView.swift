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
            date: "Abr 25",
            duration: 40,
            driver: "José Luis Mendez"
        ),
        IdentifiableTrip(
            date: "Abr 30",
            duration: 40,
            driver: "Carlos Hernandez"
        ),
        IdentifiableTrip(
            date: "Abr 31",
            duration: 40,
            driver: "Mauricio Anaya"
        ),
        IdentifiableTrip(
            date: "May 25",
            duration: 40,
            driver: "José Luis Mendez"
        ),
        IdentifiableTrip(
            date: "May 30",
            duration: 40,
            driver: "Carlos Hernández"
        ),
        IdentifiableTrip(
            date: "May 31",
            duration: 40,
            driver: "Mauricio Anaya"
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

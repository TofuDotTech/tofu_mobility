//
//  MainView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI
import MapKit

struct MainView: View {
    let manager = CLLocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 19.373037,
            longitude: -99.183606
        ),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    @State var searchText: String = ""
    
    init() {
        manager.requestWhenInUseAuthorization()
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment.top) {
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .ignoresSafeArea()
                HStack {
                    Spacer()
                    TextField("Buscar una parada", text: $searchText)
                        .textFieldStyle(.plain)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(Color("LightCoolGray"))
                        .cornerRadius(8)
                        .frame(width: 300)
                        .autocorrectionDisabled()
                    Spacer()
                    NavigationLink(destination: TripsView()) {
                        Image(systemName: "person.circle.fill")
                            .scaleEffect(2)
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top:0, leading: 8, bottom: 0, trailing: 8))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

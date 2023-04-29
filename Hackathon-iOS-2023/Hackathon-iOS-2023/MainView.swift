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
        ZStack(alignment: Alignment.top) {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .ignoresSafeArea()
            HStack {
                TextField("Buscar una parada", text: $searchText)
                    .textFieldStyle(.plain)
                    .padding()
                    .background(Color("LightCoolGray"))
                    .cornerRadius(8)
                Image(systemName: "person")
            }
            .padding()
            .background(Color("CoolGray"))
            .cornerRadius(8)
            .ignoresSafeArea()
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

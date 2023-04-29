//
//  MapTestView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct MapTestView: View {
    let manager = CLLocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.373037, longitude: -99.183606),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    @State var latitude: Double
    @State var longitude: Double
    
    init() {
        manager.requestWhenInUseAuthorization()
        latitude = manager.location?.coordinate.latitude.magnitude ?? 0.0
        longitude = manager.location?.coordinate.longitude.magnitude ?? 0.0
    }
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading) {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .ignoresSafeArea()
            
            LocationButton {
                print(latitude)
                print(longitude)
            }
            .frame(height: 44)
            .cornerRadius(8)
            
            VStack {
                Text(String(latitude))
                Text(String(longitude))
            }
        }
    }
}

struct MapTestView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestView()
    }
}

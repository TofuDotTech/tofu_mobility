//
//  MapTestView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

/* import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct MapTestView: View {
    let manager = CLLocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 19.373037,
            longitude: -99.183606
        ),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    // @State var latitude: Double = manager.location?.coordinate.latitude.magnitude ?? 0.0
    // @State var longitude: Double = manager.location?.coordinate.longitude.magnitude ?? 0.0
    @State var place: IdentifiablePlace = IdentifiablePlace(lat: 0.0, long: 0.0)
    
    init(latitude: Double, longitude: Double) {
        manager.requestWhenInUseAuthorization()
        self.place = IdentifiablePlace(lat: latitude, long: longitude)
    }
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading) {
            Map(coordinateRegion: $region, annotationItems: [place]) { place in
                MapMarker(coordinate: place.location)
            }
                .ignoresSafeArea()
            
            LocationButton {
            }
            .frame(height: 44)
            .cornerRadius(8)
        }
    }
}

struct MapTestView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestView(latitude: 0.0, longitude: 0.0)
    }
} */

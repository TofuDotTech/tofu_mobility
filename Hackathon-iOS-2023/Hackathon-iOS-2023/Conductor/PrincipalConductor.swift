//
//  PrincipalConductor.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 30/04/23.
//
import SwiftUI
import MapKit
import MapKit
import CoreLocation
import CoreLocationUI

struct PrincipalConductor: View {
    
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
        VStack
        {
            VStack(alignment: .leading)
            {
                Text("Notificación")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.leading)
                    .padding(.bottom,3)
                Text("Ve directo a donatello 6")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.leading)
            }
            .padding()
            
            ZStack(alignment:.bottom){
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .ignoresSafeArea()
                ProximaParada()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("CoolGray"))
        .navigationBarBackButtonHidden(true)
    }
}

struct PrincipalConductor_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalConductor()
    }
}

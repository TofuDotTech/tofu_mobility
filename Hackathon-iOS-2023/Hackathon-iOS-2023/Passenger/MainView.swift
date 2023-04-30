//
//  MainView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI
import MapKit

struct PassengerMainView: View {
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
    @State var isPresented: Bool = false
    @State var busDrawer: Bool = true
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    init() {
        manager.requestWhenInUseAuthorization()
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment.top) {
                //Map(coordinateRegion: $region, showsUserLocation: true)
                MapView(directions: $directions)
                    .ignoresSafeArea()
                VStack {
                    VStack {
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
                        .padding(EdgeInsets(top:50, leading: 12, bottom: 0, trailing: 12))
                    }
                    .padding(.bottom)
                    .background(Color("CoolGray"))
                    .cornerRadius(20)
                    Button(action: {
                        isPresented.toggle()
                        busDrawer.toggle()
                    }) {
                        Text("Ejemplo")
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $isPresented) {
                Group {
                    if busDrawer {
                        BottomDrawerBus()
                            .padding(EdgeInsets(top: 20, leading: 12, bottom: 0, trailing: 12))
                    } else {
                        BottomDrawerTrip()
                            .padding(EdgeInsets(top: 20, leading: 12, bottom: 0, trailing: 12))
                    }
                }
                .presentationDetents([.height(220)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

struct BottomDrawerBus: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Parada Donatello #34")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Próximo camión")
                        .font(.title3)
                        .fontWeight(.regular)
                    HStack {
                        Image(systemName: "leaf.circle.fill")
                            .foregroundColor(.green)
                        Text("Sustainable check")
                            .font(.caption)
                    }
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("30 min")
                        .font(.title3)
                        .fontWeight(.regular)
                    Text("de distancia")
                        .font(.caption)
                }
            }
            Text("Espacios para discapacitados: 2 disponibles")
                .font(.caption)
            Spacer()
            HStack {
                VStack {
                    Text("Conductor")
                        .font(.caption2)
                    Text("Jose Luis Mendez")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    Text("Placas")
                        .font(.caption2)
                    Text("A00-AAA")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    Text("Asientos disponibles")
                        .font(.caption2)
                    Text("30")
                        .font(.body)
                        .fontWeight(.semibold)
                }
            }
            Spacer()
        }
    }
}

struct BottomDrawerTrip: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Text("Estás en un viaje desde hace 30 min").font(.title3)
                Spacer()
            }
            Spacer()
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.blue)
                Text("Subiste en la parada Donatello 43")
                    .font(.body)
            }.foregroundColor(.white)
            Spacer()
            RedButton("Finalizar viaje") { }
            Spacer()
        }
    }
}

struct PassengerMainView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerMainView()
    }
}

struct MapView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @Binding var directions: [String]
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 19.373037, longitude: -99.183606),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        // 19.378429, -99.187372
        // 19.376673, -99.178110
        // 19.367884, -99.181166
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.378429, longitude: -99.187372))
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.376673, longitude: -99.178110))
        let p3 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.367884, longitude: -99.181166))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let request2 = MKDirections.Request()
        request2.source = MKMapItem(placemark: p2)
        request2.destination = MKMapItem(placemark: p3)
        request2.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p1, p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
        }
        
        let directions2 = MKDirections(request: request2)
        directions2.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p2, p3])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
        }
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .green
            renderer.lineWidth = 5
            return renderer
        }
    }
}

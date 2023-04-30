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
import AVFoundation
import SocketIO


let speechSynthesizer = AVSpeechSynthesizer()

final class Service: ObservableObject{
    private var manager =  SocketManager(socketURL: URL(string:"ws://172.29.79.27:3000")!, config:[.log(true),.compress])
        
    @Published var message  =  [String]()
    @Published var mensaje = ""

    init(){
        let socket=manager.defaultSocket
        socket.on(clientEvent: .connect) { (data,ack) in
            print("Connected")
        }
        socket.on("nuevaNotificacion"){[weak self](data,ack) in
            if let data = data[0] as? [String:String],
               let rawMessage = data["mensaje"]{
                DispatchQueue.main.async{
                    self?.message.append(rawMessage)
                    self?.mensaje = rawMessage
                    let utterance = AVSpeechUtterance(string: self?.mensaje ?? "no se puede")
                    utterance.pitchMultiplier = 1.0
                    utterance.rate = 0.5
                    utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                    
                    speechSynthesizer.speak(utterance)
                }
            }
        }

        socket.connect()
    }
    
}




struct PrincipalConductor: View {
    @ObservedObject var service = Service()
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
    private var notificacion = ""
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
            
                Text(service.mensaje)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.leading)
            }
            .padding()
            
            
            
            ZStack(alignment:.bottom){
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .ignoresSafeArea()
                VStack(alignment: .trailing){
                    
                    
                    NavigationLink(destination: Notificaciones()) {
                       Image(systemName: "bell.fill")
                                .resizable()
                                .frame(width: 25,height: 25)
                        
                    }
                    .frame(width: 60,height: 60)
                    .background(Color("CoolGray"))
                    .clipShape(Circle())
                    .padding()
                    Button{
                        let utterance = AVSpeechUtterance(string: service.mensaje)
                        utterance.pitchMultiplier = 1.0
                        utterance.rate = 0.5
                        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                        
                        speechSynthesizer.speak(utterance)
                    } label: {
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 25,height: 25)
                    }
                    .frame(width: 60,height: 60)
                    .background(Color("CoolGray"))
                    .clipShape(Circle())
                    .padding()
                    ProximaParada()
    
                }
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

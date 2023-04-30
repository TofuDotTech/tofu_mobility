//
//  Notificaciones.swift
//  Hackathon-iOS-2023
//
//  Created by Jyaru Hernandez on 30/04/23.
//

import SwiftUI
import AVFoundation

struct IdentifiableNotificacion: Identifiable {
    var id: UUID = UUID()
    var hour: String
    var descripcion: String
}

struct Notificaciones: View {
    var notificaciones = [
        IdentifiableNotificacion(
            hour:"15:00",
            descripcion: "Ve directo a donatello"
        ),
        IdentifiableNotificacion(
            hour:"15:30",
            descripcion: "Cuidado con la calle 5"
        )
    ]
    
    
    var body: some View {
            VStack(){
                ForEach(notificaciones) { notificacione in
                    VStack(alignment:.leading){
                        Button(action:{
                            let utterance = AVSpeechUtterance(string:notificacione.descripcion)
                            utterance.pitchMultiplier = 1.0
                            utterance.rate = 0.5
                            utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                            
                            speechSynthesizer.speak(utterance)
                        }, label:{
                            HStack(alignment: .top){
                                Text(notificacione.descripcion)
                                Text(notificacione.hour)
                                Spacer()
                            }
                        })
                        .padding(.bottom,15)
                        
                    }
                    
                }
            }
            .padding(EdgeInsets(top: 50, leading: 16, bottom: 0, trailing: 8))
            .navigationTitle("Rutas")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
    }
}

struct Notificaciones_Previews: PreviewProvider {
    static var previews: some View {
        Notificaciones()
    }
}

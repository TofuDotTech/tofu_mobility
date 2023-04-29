//
//  TextToSpeechTestView.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import SwiftUI
import AVFoundation

let speechSynthesizer = AVSpeechSynthesizer()

struct TextToSpeechTestView: View {
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Button(
                action: {
                    let utterance = AVSpeechUtterance(string: "Hola Juary")
                    utterance.pitchMultiplier = 1.0
                    utterance.rate = 0.5
                    utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                    
                    speechSynthesizer.speak(utterance)
                }
            ) {
                Text("Speak")
            }
        }
    }
}

struct TextToSpeechTestView_Previews: PreviewProvider {
    static var previews: some View {
        TextToSpeechTestView()
    }
}

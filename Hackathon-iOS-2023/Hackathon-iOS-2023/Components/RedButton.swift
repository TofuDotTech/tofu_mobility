//
//  RedButton.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 30/04/23.
//

import SwiftUI

struct RedButton: View {
    var textLabel: String
    var action: () -> Void
    
    init(_ textLabel: String, action: @escaping () -> Void) {
        self.textLabel = textLabel
        self.action = action
    }
    
    var body: some View {
        Button(action: self.action) {
            Spacer()
            Text(textLabel).font(.title2)
            Spacer()
        }
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.borderedProminent)
        .tint(Color("CoolRed"))
    }
}

struct RedButton_Previews: PreviewProvider {
    static var previews: some View {
        RedButton("Reportar viaje") {}
    }
}

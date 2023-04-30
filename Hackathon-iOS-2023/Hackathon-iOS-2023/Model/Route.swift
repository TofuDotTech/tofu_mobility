//
//  Route.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 29/04/23.
//

import Foundation

struct IdentifiableRoute: Identifiable {
    var id: UUID = UUID()
    var name: String
    var from: String
    var to: String
}

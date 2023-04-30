//
//  Network.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 30/04/23.
//

// Network.swift

import SwiftUI
import Foundation

struct User: Identifiable, Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company

    struct Address: Decodable {
        var street: String
        var suite: String
        var city: String
        var zipcode: String
        var geo: Geo

        struct Geo: Decodable {
            var lat: String
            var lng: String
        }
    }

    struct Company: Decodable {
        var name: String
        var catchPhrase: String
        var bs: String
    }
}

struct Transporte: Decodable {
    var success: Bool
    var parada: Parada
    var camionProximo: Camion
    
    struct Parada: Decodable {
        var id: String
        var nombre: String
        var numero: Int
        var rutaId: String
    }
    
    struct Camion: Decodable {
        var id: String
        var paradaActual: String
        var espaciosReservados: Int
        var modelo: String
        var placas: String
        var capacidad: Int
        var conductores: [Conductor]
        var _count: Count
    }
    
    struct Conductor: Decodable {
        var id: String
        var usuarioId: String
        var usuarios: Usuarios
        var transporteId: String
    }
    
    struct Count: Decodable {
        var viajes: Int
    }
    
    struct Usuarios: Decodable {
        var nombre: String
    }
}

struct StateResponse: Decodable {
    var success: Bool
    var estado: Bool
}

class Network: ObservableObject {
    // @Published var users: [User] = []
    @Published var parada: Transporte? = nil
    @Published var disponibles: Int = 0
    @Published var enViaje: Bool? = nil
    
    let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTBiNWJmMi1lN2MwLTQ4MTUtYjk3YS03NWIwOTM1ZTg1MmQiLCJpYXQiOjE2ODI4ODI0NDkxNDgsImV4cCI6MTY4Mjg4Mzc0NTE0OH0.Ph2nUJmbyMytu7sPsZQwLqSO3KhGpAIcy-Ib_6ZxQYCByqHu-KFftSV_rHS1r1RsOPA7Xmip04WTAcD0fWrHVSe2e0nXIEgbTCmQWEj8UBuR4kcoIC3spKcCX1uCp2PnbuxvjpWnjjvHwqhrXmA57cX2bZb8BxIY1jF2Ge6EhyhuyhW4dJx91VnLMHbCMl7Jvh8S-0fct2gRBLWCSKLqyPnXz7NLarsWvZYcYFnkn97OYcxtpqHoQq1AhwP8ox0qS8VojpW4uIfsEvB1U-vT3AIkUYZuRCSgSfakdu_VVbTKrJ3f3XKb0cTKhYHUqQzp3k4lKLntdiVZLIZhcYwLNiDfD4KO1qfeVvocDqg4yPbYZkP6VJKq7DPv9enbBTIYHv303dFcRodUxwvfR8_B96Xgww0O36un1MzHM8bh_0f0GoKsPjwZDJopsYSCMFIY4mFYHFST0Heo_mVFLQBBZqd8tlMg6SPs8oGIbBZI7AfZDtf6SeNoZ8pRvzY1JnTSvJUzrbH2znpcP0kABnqpBOj863uZhKnS2QlF9Y4HoqyzEq29r2huAMdUIhD636NCsTHIy98fH51FjRiaD9C4OguLv32jVMSaH90ZpD8kgwS6CqJnjRPAdvcf1voMHX5-tsTX8iYsVQvONt40lOIOO82MeQBDrLoRRl7QNtAtrgo"
    
    func getStop() {
        guard let url = URL(string: "http://172.29.79.27:3000/api/v1/paradas/transporte") else { fatalError("Missing URL") }
        let body: [String: Any] = ["paradaId": "ca0ededb-ac11-47f7-8854-743241fbffbb"] // poner este
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedStop = try JSONDecoder().decode(Transporte.self, from: data)
                        self.parada = decodedStop
                        print("Success: ", String(self.parada?.success ?? false))
                        let capacidad = decodedStop.camionProximo.capacidad
                        let reservados = decodedStop.camionProximo.espaciosReservados
                        self.disponibles = capacidad - reservados
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func getInCurrentRoute() {
        guard let url = URL(string: "http://172.29.79.27:3000/api/v1/viajes/estado") else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedState = try JSONDecoder().decode(StateResponse.self, from: data)
                        self.enViaje = decodedState.estado
                        print("Success: ", decodedState.success)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func putCurrentRoute() {
        guard let url = URL(string: "http://172.29.79.27:3000/api/v1/viajes/estado") else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            
            if response.statusCode == 200 {
                // guard let data = data else { return }
                print("Success")
            /*  DispatchQueue.main.async {
                    do {
                        let decodedState = try JSONDecoder().decode(StateResponse.self, from: data)
                        self.enViaje = decodedState.estado
                        print("Success")
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                } */
            }
        }

        dataTask.resume()
    }
}

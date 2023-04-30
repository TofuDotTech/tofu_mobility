//
//  ProximaParada.swift
//  Hackathon-iOS-2023
//
//  Created by Iván Vega on 30/04/23.
//
import SwiftUI



struct ProximaParada: View {
    @State var cardShown = false
    
    
    var body: some View {
        ZStack(){
            VStack(){
                Text("Próxima parada")
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.top,10)
                    .padding(.leading)
                Text("Donatello #45")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.top,10)
                    .padding(.bottom,20)
                    .padding(.leading)
                RedButton("Notificar problema"){
                    cardShown.toggle()
                }
                .padding(.leading, 20)
                .padding(.trailing,20)
            }
            .padding(.bottom,30)
            .background(Color("CoolGray"))
            .cornerRadius(20)
        }
        .sheet(isPresented: $cardShown){
            Contenido()
            .presentationDetents([.height(400)])
        }
    }
}

struct Contenido: View{
    @State var selected = ""
    var selectables = [
        IdentifiableSelectable("Asalto"),
        IdentifiableSelectable("Problema vial"),
        IdentifiableSelectable("Mensaje personalizado"),
    ]
    var body: some View{
        VStack(alignment: .leading){
            Text("¿Qué quieres notificar?")
                .font(.title)
                .padding(.bottom)
            ForEach(selectables) { selectable in
                Button(action: { selected = selectable.value }) {
                    HStack {
                        if selected == selectable.value {
                            Image(systemName: "circle.fill")
                        }
                        else {
                            Image(systemName: "circle")
                        }
                        Text(selectable.value)
                    }.foregroundColor(.white)
                }
                .padding(.bottom)
            }
            RedButton("Enviar notificación"){
                print("enviar notificación")
            }
        }
        .padding(.leading,50)
        .padding(.trailing,50)
    }
}

struct ProximaParada_Previews: PreviewProvider {
    static var previews: some View {
        ProximaParada()
    }
}

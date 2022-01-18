//
//  TrajetInfoView.swift
//  TrajetInfoView
//
//  Created by Giovanni Fioretto on 10/12/2021.
//

import SwiftUI

struct TrajetInfoView: View {
    @State private var heure: String = "11"
    @State private var minutes: String = "23"
    @State private var temps: String = "12"
    @State private var km: String = "3"
    var body: some View {
        HStack{
            Image("pointer")
                .resizable()
                .frame(width: 45, height :45)
            VStack{
                Text("Arrivée:")
                Spacer()
                    .frame(height: 5)
                HStack{
                    Text(heure)
                    Spacer()
                        .frame(width: -10)
                    Text(":")
                    Spacer()
                        .frame(width: -10)
                    Text(minutes)
                }
            }
            Divider()
                .frame(height: 45)
            Image("clock")
                .resizable()
                .frame(width: 45, height :45)
            VStack{
                Text("Temps:")
                Spacer()
                    .frame(height: 5)
                HStack{
                    Text(temps)
                    Spacer()
                        .frame(width: 3)
                    Text("mn")
                }
                
            }
            Divider()
                .frame(height: 45)
            Image("distance")
                .resizable()
                .frame(width: 45, height :45)
            VStack{
                Text("Distance:")
                Spacer()
                    .frame(height: 5)
                HStack{
                    Text(km)
                    Spacer()
                        .frame(width: 3)
                    Text("Km")
                }
                
            }
        }
    }
}

struct TrajetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrajetInfoView()
    }
}

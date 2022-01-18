//
//  BaladesView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 15/12/2021.
//

import SwiftUI

struct BaladesView: View {
    
    @State var rayonSlider: Double = 0
    @State var timeSlider: Double = 0
    @State var difficultySlider: Double = 0
    
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 10){
//            Spacer()
            HStack {
                Text("Balades")
                    .padding(.horizontal)
                Spacer()
            }
            Divider()
            
            
//            ZStack {
//                Rectangle()
//                    .frame(width: 330, height: 170, alignment: .center)
//                    .foregroundColor(.white)
//                // couleur à changer avec la modale de la bonne couleur
//                    .cornerRadius(10)
//                    .shadow(color: Color.black, radius: 10)
                
            VStack(alignment: .leading, spacing: 0) {
                    
                    HStack{
                        Text("Rayon")
                        Slider(value: $rayonSlider, in: 0...50)
//                            .frame(width: 150)
                        
                        Text(" \(String(format: "%0.0.0f", rayonSlider)) Km")
                            .frame(width: 80)
                    }
                    .padding()
                    
                    
                    HStack{
                        Text("Durée")
                        
                        Slider(value: $timeSlider, in: 0...120)
//                            .frame(width: 150)
                        Text("\(String(format: "%0.0.0f", timeSlider)) Mn")
                            .frame(width: 80)
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Text(" Effort")
                        Slider(value: $difficultySlider, in: 0...3)
//                            .frame(width: 150)
                        Text("\(String(format: "%0.0f", difficultySlider))")
                            .frame(width: 80)
                        
                    }
                    .padding()
                    
                    
                }
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)
                .padding(.horizontal, 10)
                
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Go")
                }
                .alert("Balades", isPresented: $showAlert) {
                    Text("OK")
                } message: {
                    Text("Bientôt 👀 dans la version 2")
                }
                .buttonStyle(.bordered)
                .tint(Color("blueVilo"))
                

            
            .padding(10)
        }
    }
}

struct BaladesView_Previews: PreviewProvider {
    static var previews: some View {
        BaladesView()
    }
}

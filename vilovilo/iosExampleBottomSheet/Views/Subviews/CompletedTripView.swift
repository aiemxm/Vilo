//
//  CompletedTripView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 15/12/2021.
//

import SwiftUI

struct CompletedTripView: View {
    
    @ObservedObject var viewModel: BottomSheetModel
    @ObservedObject var disruption =  BottomSheetModel.disruptionBS

    
    var body: some View {
       
        
        VStack{
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
        Text("Vous êtes bien arrivé !")
                .font(.title)
                .bold()
            
            Spacer()
                .frame(height: 50)
            
            Text("Avez vous eu un problème durant votre trajet ?")
                .font(.subheadline)
                .font(.title2)
           Spacer()
                .frame(height: 50)
            
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.context = .landing
                    viewModel.position = .middle
                }, label: {
                    Text("Non")
                        .font(.title)
                        .frame(width: 60, height: 30)
                        .padding()
                        .background(Color("blueVilo"))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                })
                
                Spacer()
                
                Button(action: {
                    viewModel.position = .hidden
                    disruption.position = .middle
                }, label: {
                    Text("Oui")
                        .font(.title)
                        .frame(width: 60, height: 30)
                        .padding()
                        .background(Color("blueVilo"))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                })
                
                Spacer()
            }
            
        }
    }
}

struct CompletedTripView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTripView(viewModel: .homeBS)
    }
}

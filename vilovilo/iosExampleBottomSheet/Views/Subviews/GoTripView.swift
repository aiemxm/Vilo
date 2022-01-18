//
//  GoTripView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct GoTripView: View {
    
    @ObservedObject var viewModel : BottomSheetModel
    @ObservedObject var user = User.globalUser
    
    
    var textTime: Double = 12
    var textIcon: String {
        switch user.preferredTripType {
        case .fast:
            return "🐆"
        case .secure:
            return "👌"
        case .nice:
            return "🌳"
        case .discovery:
            return "👀"
        default:
            return "🐆"
        }
    }
    

    
    var body: some View {
        
        HStack{
            Button {
                // retour vers le choix des types de trajets:
                viewModel.context = .tripChoice
                user.preferredTripType = .none
                
            } label: {
                Text(textIcon)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("blueVilo"))
                    .clipShape(Circle())
                
            }
            
            Spacer()
            
            Text("\(textTime, specifier : "%.0f") minutes")
                .foregroundColor(.white)
                .padding()
                .background(Color("blueVilo"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            
            Spacer()
            
            Button {
                // go to full screen with spatial directions:
                viewModel.context = .tripInProgress
                viewModel.position = .bottom
                viewModel.go = true
            } label: {
                Text("Go !")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("blueVilo"))
                    .clipShape(Circle())
            }



        }
        
        .frame(maxHeight: 50)
    }
}

struct GoTripView_Previews: PreviewProvider {
    static var previews: some View {
        GoTripView(viewModel: .homeBS)
    }
}

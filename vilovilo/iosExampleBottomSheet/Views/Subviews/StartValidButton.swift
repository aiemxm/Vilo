//
//  StartValidButton.swift
//  ExtractedViewsVilo
//
//  Created by Maxime Bégué on 02/12/2021.
//

import SwiftUI

struct StartValidButton: View {
    var buttonText: String
    @Binding var tap: Bool
    
    var body: some View {
        
        Button(action: {tap.toggle()}) {
            ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 140, height: 40)
                .foregroundColor(Color("blueVilo"))
            Text(buttonText)
                .foregroundColor(.white)
            }
        }


    }
}

struct StartValidButton_Previews: PreviewProvider {
    static var previews: some View {
        StartValidButton(buttonText: "bouton", tap: .constant(false))
    }
}

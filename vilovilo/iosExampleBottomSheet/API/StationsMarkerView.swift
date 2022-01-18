//
//  StationsMarkerView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 14/12/2021.
//

import SwiftUI

struct StationsMarkerView: View {
    
    var title: String = "Benjamin Godard - Victor Hugo"
    
    @State private var showTitle = false
    
    var body: some View {
        
        Button {
            showTitle.toggle()
        } label: {
            Image("mark")
                .scaleEffect(x: 0.1, y: 0.1)
                .frame(width: 200, height: 100)
                .overlay {
                    if showTitle {
                    Text(title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 12).tint(Color("blueVilo")))
                        .offset(x: 0, y: -70)
                    }
                }
        }
    }
}

struct StationsMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        StationsMarkerView()
    }
}

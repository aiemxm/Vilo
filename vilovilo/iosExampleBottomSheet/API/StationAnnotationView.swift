//
//  StationAnnotationView.swift
//  SwiftAnnotation
//
//  Created by Apprenant 86 on 14/12/2021.
//

import SwiftUI

struct StationAnnotationView: View {
    
    let title: String
    
    @State private var showTitle = true
    
    var body: some View {
       
        VStack(spacing: 0) {
              Text(title)
                .foregroundColor(.primary)
                .font(.callout)
                .padding(5)
                .background(.quaternary)
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
              
             Image("mark")
                .resizable()
                .scaledToFit()
//                .frame(width: 200, height: 200)

            }
        .frame(width: 100, height: 100)
            .onTapGesture {
              withAnimation(.easeInOut) {
                showTitle.toggle()
              }
            }
    }
}


struct StationAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        StationAnnotationView(title: "Benjamin Godard - Victor Hugo")
    }
}

//
//  DetailView.swift
//  Itinerar
//
//  Created by Joffrey Freixanet on 07/12/2021.
//

import SwiftUI

struct TripSummaryView: View {
    
    @Binding var type: PreferredTripType
    
    var textIcon: String {
        switch type {
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
        
        VStack {
            ExtractedView(textTime: 12, textIcon: textIcon, textDistance: 3.0, textBike: 10, textWork: 2)
            
        }
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripSummaryView(type: .constant(.fast))
    }
}

struct ExtractedView: View {
    
    var textTime: Double
    var textIcon: String
    var textDistance: Double
    var textBike: Int
    var textWork: Int
    
    
    var body: some View {
        VStack{
//            Spacer()
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
//
//                ZStack{
//                    VStack{
//                        Text(textIcon)
//                            .font(.system(size: 30))
//                        Text("\(textTime, specifier : "%.0f") minutes")
//                            .font(.system(size: 20))
//
//                    }
//
//                }
//
//                .frame(width: 325, height: 38)
//                .padding()
//                .background(Color("blueVilo"))
//                .cornerRadius(10)
//                .foregroundColor(.white)
//
//            }
            
            Text("\(textDistance, specifier : "%.1f") Km")
            
            Divider()
                .padding(.horizontal, 35)
            
            Text("\(textBike) % pistes cyclables")
            Divider()
                .padding(.horizontal, 35)
            
            Text("\(textWork) endroit(s) de travaux")
            
//            Spacer()
            
        }
        .padding()
    }
}

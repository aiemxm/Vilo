//
//  FloatingButtonsView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 06/12/2021.
//

import SwiftUI
import CoreLocationUI
import CoreLocation
import MapKit

struct FloatingButtonsView: View {
    
    @ObservedObject var homeBS = BottomSheetModel.homeBS
    @ObservedObject var weatherBS = BottomSheetModel.weatherBS
    @ObservedObject var profileBS = BottomSheetModel.profileBS
    @ObservedObject var disruptionBS = BottomSheetModel.disruptionBS
    @ObservedObject var favoriteBS = BottomSheetModel.favoriteBS
    
    @Binding var showStations: Bool
    
    var showButtons: Bool {
        !(homeBS.position == .top || weatherBS.position == .top || profileBS.position == .middle || profileBS.position == .top || disruptionBS.position == .middle || homeBS.context == .tripChoice || homeBS.context == .tripSummary)
    }
    
    var square: Bool {
        (homeBS.position == .middle || weatherBS.position == .middle || profileBS.position == .middle || disruptionBS.position == .middle || favoriteBS.position == .middle)
    }

    
    var body: some View {
        GeometryReader { geometryProxy in
            if showButtons {
                VStack{
                    HStack {
                        Button(action: {
                            homeBS.position = .middle
                            profileBS.position = .middle
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                
                                .frame(width: 30, height: 30)
                                .padding(10)
                                
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .background(Color("blueVilo"))
                                .cornerRadius(12)
                                
                                .shadow(radius: 8, x: 4, y: 4)
                        }

                        Spacer()
                        
                        Button(action: {
                            homeBS.position = .hidden
                            weatherBS.position = .top
                        }) {
                            Image(systemName: "cloud.sun.fill")
                                .resizable()
                                .scaledToFit()
                                
                                .frame(width: 30, height: 30)
                                .padding(10)
                                
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .background(Color("blueVilo"))
                                .cornerRadius(12)
                                
                                .shadow(radius: 8, x: 4, y: 4)
                        }
                    }

                    Spacer()
                    HStack{
                        Button(action: {
                            homeBS.position = .hidden
                            disruptionBS.context = .disruption
                            disruptionBS.position = .middle

                        }) {
                            Image(systemName: "eye.trianglebadge.exclamationmark.fill")
                                .resizable()
                                .scaledToFit()
                                
                                .frame(width: 30, height: 30)
                                .padding(10)
                                
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .background(Color("blueVilo"))
                                .cornerRadius(12)
                                
                                .shadow(radius: 8, x: 4, y: 4)
                        }
                        
                        Spacer()

                        
//                        Button(action: {}) {
//                            Image(systemName: "location.square.fill")
//                                .font(.system(size: 40))
//                                .shadow(radius: 8, x: 4, y: 4)
//                        }
                    }
                }
                .padding()
                .foregroundColor(Color("blueVilo"))
                .frame(height: square ? geometryProxy.size.height*0.57 : geometryProxy.size.height*0.9)
            .animation(.default, value: square)
            }
        }
    }
}

struct FloatingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FloatingButtonsView(showStations: .constant(false))
//            FloatingButtonsView()
        }
    }
}

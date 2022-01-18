//
//  ContentView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI
import BottomSheet
import MapKit
import CoreLocation
import CoreLocationUI

struct ContentView: View {
    
    @ObservedObject var homeBS = BottomSheetModel.homeBS
    @ObservedObject var weatherBS = BottomSheetModel.weatherBS
    @ObservedObject var profileBS = BottomSheetModel.profileBS
    @ObservedObject var disruptionBS = BottomSheetModel.disruptionBS
    @ObservedObject var favoriteBS = BottomSheetModel.favoriteBS
    
    @StateObject private var viewModel = MapViewModel()
    
    @State private var tap = false
    
    let velibStations = loadJson(filename: "station_information")
    
    var square: Bool {
        (homeBS.position == .middle || weatherBS.position == .middle || profileBS.position == .middle || disruptionBS.position == .middle || favoriteBS.position == .middle)
    }
    
    @State private var showStations = false

    var body: some View {
        
        ZStack {
            
//            if showStations {
                
                MapView(region: $viewModel.region, locationManager: $viewModel.locationManager, lat: homeBS.lat, lon: homeBS.lon, showDefaultTrip: $homeBS.go, showStations: $showStations )
                    .ignoresSafeArea()
                    .offset(y: (square ? -200 : 0) )
                    .animation(.default, value: square)
                
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: velibStations!.data.stations) { item in
//
//
//                MapAnnotation(coordinate: .init(latitude: item.lat, longitude: item.lon), anchorPoint: CGPoint(x: 0.5, y: 1) ) {
//                    StationsMarkerView(title: item.name)
//                }
//
//            }
//                .ignoresSafeArea()
//                .offset(y: (square ? -200 : 0) )
//                .animation(.default, value: square)
                
//            } else {
//            
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//                .ignoresSafeArea()
//                .offset(y: (square ? -200 : 0) )
//                .animation(.default, value: square)
//                
//            }
            
            

            FloatingButtonsView(showStations: $showStations)
            
            GeometryReader { proxy in
                
                VStack{

                    LocationButton(.currentLocation) {
                        viewModel.requestAllowOnceLocationPermission()
                        print("location button")
                    }
                    .font(.system(size: 20))
                    .cornerRadius(.infinity)
                    .foregroundColor(Color.white)

                    .tint(Color("blueVilo"))
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
//                    .shadow(radius: 4)
                    
                    
                    Button {
                        showStations.toggle()
                    } label: {
                        Image(systemName: "bicycle")
                            .resizable()
                            .scaledToFit()
                            
                            .frame(width: 30, height: 30)
                            .padding(10)
                            
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .background(Color("blueVilo"))
                            .cornerRadius(12)
                            .shadow(radius: 4, x: 4, y: 4)
                    }
                    
                }
                .position(square ? CGPoint(x: proxy.size.width*0.90, y: proxy.size.height*0.48) : CGPoint(x: proxy.size.width*0.90, y: proxy.size.height*0.81)).animation(.default, value: square)
                
            }
            
        }
        .bottomSheet(bottomSheetPosition: $homeBS.position,
                     options: homeBS.options,
                     headerContent: {
            HomeHeaderView()
            
//                                                homeBS.headerView().onTapGesture {
//
//                                                homeBS.position = .top
//                                                homeBS.context = .search
//                                                }
                                    },
                     mainContent: { HomeMainView() }
        )
    
        .bottomSheet(bottomSheetPosition: $weatherBS.position,
                     options: weatherBS.options,
                     headerContent: { WeatherHeaderView() },
                     mainContent: { WeatherMainView() }
        )
        
        .bottomSheet(bottomSheetPosition: $profileBS.position,
                     options: profileBS.options,
                     headerContent: { ProfileHeaderView() },
                     mainContent: { ProfileMainView() }
        )
        
        .bottomSheet(bottomSheetPosition: $disruptionBS.position,
                     options: disruptionBS.options,
                     headerContent: { DisruptionHeaderView() },
                     mainContent: { DisruptionMainView() }
        )
        
        .bottomSheet(bottomSheetPosition: $favoriteBS.position,
                     options: favoriteBS.options,
                     headerContent: { FavoriteHeaderView() },
                     mainContent: { FavoriteMainView() }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
        
    }
}

//
//  LandingSheetView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI

struct HomeMainView: View {
    
    @ObservedObject var viewModel = BottomSheetModel.homeBS
    @ObservedObject var user = User.globalUser
    
    @State private var destination: String = ""
    @State private var tap = false
    
    @State private var queryString = ""
    
    var body: some View {
        
        if (viewModel.context == .landing){
            LandingView(destination: $viewModel.destination)
                .onChange(of: viewModel.destination) { newValue in
//                    viewModel.destination = newValue
                    viewModel.position = .middle
                    viewModel.context = .tripChoice
                }
        }
        
        if (viewModel.context == .search(type: .destination)){
            if viewModel.destination.isEmpty {
                RecentsView(tap: $tap, choice: $destination)
                    .onChange(of: destination) { newValue in
                        viewModel.destination = newValue
                        viewModel.position = .middle
                        viewModel.context = .tripChoice
                    }
            } else {
                SuggestionsView(viewModel: .homeBS, tap: $tap)
                    .onChange(of: tap) { newValue in
                        viewModel.position = .middle
                        viewModel.context = .tripChoice
                    }
            }
            
        }
        
        if viewModel.context == .tripChoice {
            TripChoiceView(choice: $user.preferredTripType)
                .onChange(of: user.preferredTripType) { newValue in
//                    user.preferredTripType = newValue
                    viewModel.context = .tripSummary
                }
        }
        
        if viewModel.context == .tripSummary {
            TripSummaryView(type: $user.preferredTripType)
        }
        
        if viewModel.context == .tripInProgress {
            TrajetInfoView()
                
        }
        
        if viewModel.context == .completedTrip {
            CompletedTripView(viewModel: .homeBS)
        }
        
    }
}

struct LandingMainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMainView()
    }
}

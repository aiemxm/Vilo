//
//  LandingHeaderView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct HomeHeaderView: View {
    
    @ObservedObject var viewModel = BottomSheetModel.homeBS
    
    var body: some View {
        
        if viewModel.context == .landing {
            SearchBar(viewModel: .homeBS)
                .padding([.top, .bottom])
                .onTapGesture {
                    viewModel.context = .search(type: .destination)
                    viewModel.position = .top
                }
        }
        
        if viewModel.context == .search(type: .destination) {
            SearchBar(viewModel: .homeBS)
                .padding([.top, .bottom])
        }
        
        if viewModel.context == .tripChoice {
            HStack {
                Button {
                    viewModel.context = .landing
                    viewModel.position = .middle
                    viewModel.destination = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.title)
                        .foregroundColor(Color(.systemGray3))
                }

                
                SearchBar(viewModel: .homeBS)
                    .padding([.top, .bottom])
                    .onTapGesture {
                        viewModel.destination = ""
                        viewModel.context = .search(type: .destination)
                        viewModel.position = .top
                }
            }
        }
        
        if viewModel.context == .tripSummary {
            GoTripView(viewModel: .homeBS)
        }
        
        if viewModel.context == .tripInProgress {
            TrajetInfoView()
                .onTapGesture {
                    viewModel.position = .middle
                    viewModel.context = .completedTrip
                }
        }
        
    }
}

struct LandingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}

//
//  IncidentReportView.swift
//  BottomSheet (iOS)
//
//  Created by Maxime Bégué on 06/12/2021.
//

import SwiftUI

struct DisruptionMainView: View {
    
    @ObservedObject var viewModel = BottomSheetModel.disruptionBS
    @ObservedObject var homeBS = BottomSheetModel.homeBS
    
    @State private var add = false
    
    @State private var tap = false
    
    @State private var accident = false
    @State private var travaux = false
    @State private var obstacle = false
    
    @State private var incidentAddress = ""
    
//    @State var text: String
    
    var body: some View {
        
        if viewModel.context == .disruption {
            VStack{
                
                SearchBar(viewModel: .disruptionBS)
                    .onTapGesture {
                        viewModel.position = .top
                        viewModel.context = .search(type: .incident)
                    }
                    .padding(.vertical, 10)
                
                HStack{
                    VStack {
                        Button(action: {
                            self.accident = true
                            self.travaux = false
                            self.obstacle = false
                        }) {
                            Image("accident")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        
                        Text("Accident")
                            .font(.headline)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(accident ? Color("blueVilo") : Color(""), lineWidth: 2))
                    
                   Spacer()
                    
                    VStack {
                        Button(action: {
                            self.accident = false
                            self.travaux = true
                            self.obstacle = false
                        }) {
                            Image("travaux")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        Text("Travaux")
                            .font(.headline)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(travaux ? Color("blueVilo") : Color(""), lineWidth: 2))
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            self.accident = false
                            self.travaux = false
                            self.obstacle = true
                        }) {
                            Image("obstacle")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        Text("Obstacle")
                            .font(.headline)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(obstacle ? Color("blueVilo") : Color(""), lineWidth: 2))
                    

                }
                .padding(.horizontal)
                
                StartValidButton(buttonText: "Ajouter", tap: $add)
                    .alert("Incident ajouté", isPresented: $add) {
                        Text("OK")
                    }
                    .onChange(of: add, perform: { newValue in
                        viewModel.position = .hidden
                        homeBS.position = .middle
                        homeBS.context = .landing
                    })
                    .padding(10)
                    
                Spacer()
            }
        }
        
        if viewModel.context == .search(type: .incident){
            VStack{
                SearchBar(viewModel: viewModel)
                    .padding(.vertical)
                if viewModel.destination.isEmpty {
                    RecentsView(tap: $tap, choice: $incidentAddress)
                        .onChange(of: tap) { newValue in
                            viewModel.destination = incidentAddress
                            viewModel.position = .middle
                            viewModel.context = .disruption
                        }
                }
                else {
                    SuggestionsView(viewModel: .disruptionBS, tap: $tap)
                }
                Spacer()
            }
            
        }
        
    }
}

struct DisruptionMainView_Previews: PreviewProvider {
    static var previews: some View {
        DisruptionMainView()
    }
}

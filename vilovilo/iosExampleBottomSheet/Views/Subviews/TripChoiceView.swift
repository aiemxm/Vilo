//
//  TripChoiceView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct TripChoiceView: View {
    
    @Binding var choice: PreferredTripType
    
    var body: some View {
        
        VStack{
            HStack{
                Text ("Type de trajet")
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            Divider().background(Color.primary)

            HStack {
                VStack {
                    Button(action: {
                        choice = .fast
                    }) {
                        Text("🐆")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("blueVilo"), lineWidth: 2)
                    )
                    
                    Text("Rapide")
                        .font(.footnote)
                }
                
                VStack {
                    Button(action: {
                        choice = .nice
                    }) {
                        Text("🌳")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("blueVilo"), lineWidth: 2)
                    )
                    
                    Text("Agréable")
                        .font(.footnote)
                }
                
                VStack {
                    Button(action: {
                        choice = .discovery
                    }, label: {
                        Text("👀")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50)
                            .padding()

                        
                    })
                        .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("blueVilo"), lineWidth: 2)
                        )
                    
                    Text("Découverte")
                        .font(.footnote)
                }
                
                VStack {
                    Button(action: {
                        choice = .secure
                    }) {
                        Text("👌")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("blueVilo"), lineWidth: 2)
                    )
                    
                    Text("Sécurisé")
                        .font(.footnote)
                }
            }
        }
        .padding()
    }
}

struct TripChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        TripChoiceView(choice: .constant(.fast))
    }
}

//
//  BookmarksBlockView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI
import MapKit

struct BookmarksBlockView: View {
    
    @ObservedObject var homeBS = BottomSheetModel.homeBS
    @ObservedObject var favoriteBS = BottomSheetModel.favoriteBS
    @ObservedObject var user = User.globalUser
    
    @Binding var destination: String
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Favoris")
                Spacer()
                Button("Tout voir", action: {})
            }
            
            Divider()
            
            ScrollView(.horizontal){
                HStack{
                    FavoriteButton(subtitle: "Domicile", iconeName: "house.circle.fill"){
                        
                        destination = user.homeAddress
                    }
                    
                    FavoriteButton(subtitle: "Travail", iconeName: "briefcase.circle.fill"){
                        
                        destination = user.officeAddress
                    }
                    
                    ForEach(user.favorites, id: \.place.id){ fav in
                        
                        FavoriteButton(subtitle: fav.place.name, iconeName: fav.icon.rawValue){
                            
                            destination = fav.place.address
                        }
                    }
                    
                    FavoriteButton(subtitle: "Ajouter", iconeName: "plus.circle"){
                        
                        homeBS.position = .hidden
                        favoriteBS.position = .top
                    }
                    
                    Spacer()
                }
                .padding()
                
                
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 4)
            .padding(10)
            
        }
        .padding(10)
    }
}

struct BookmarksBlockView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksBlockView(destination: .constant(""))
    }
}

struct FavoriteButton: View {
    
    let subtitle: String
    let iconeName: String
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Image(systemName: iconeName)
                    .font(.system(size: 50))
                    .foregroundColor(Color("blueVilo"))
            }
            Text(subtitle)
        }
        .padding([.leading,.trailing], 5)
    }
}

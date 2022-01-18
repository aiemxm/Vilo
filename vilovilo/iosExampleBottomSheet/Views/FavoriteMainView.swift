//
//  AddFavouriteView.swift
//  pageFavori
//
//  Created by Giovanni Fioretto on 02/12/2021.
//

import SwiftUI

struct FavoriteMainView: View {
    
    @ObservedObject var user = User.globalUser
    @ObservedObject var favoriteBS = BottomSheetModel.favoriteBS
    @ObservedObject var homeBS = BottomSheetModel.homeBS
    
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var icon: IconeBookmark = .heart
    
    @State private var tapHeart = false
    @State private var tapFork = false
    @State private var tapStar = false
    @State private var tapCart = false
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading){
                Text("Nom")
                    .font(.title2)
                
                TextField("nom du favori",text : $name)
                    .padding()
                Text("Adresse")
                    .font(.title2)
                TextField("Barre de recherche",text : $address)
                    .padding()
                Text("Icone")
                    .font(.title2)
                HStack{
                    Spacer()
                    Button(action: {
                        icon = .heart
                        self.tapHeart = true
                        self.tapFork = false
                        self.tapStar = false
                        self.tapCart = false
                    }) {
                        Text(Image(systemName: "heart.fill"))
                            .foregroundColor(tapHeart ? Color("blueVilo") : .white)
                            .font(.title)
                            .frame(width: 70, height: 70)
                        
                            .background(tapHeart ? Color.white : Color("blueVilo"))
                            .clipShape(Circle())
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color("blueVilo"), style: StrokeStyle(lineWidth: 5))
                            )
                    }
                    Spacer()
                    Button(action: {
                        icon = .fork
                        self.tapHeart = false
                        self.tapFork = true
                        self.tapStar = false
                        self.tapCart = false
                    }) {
                        Text(Image(systemName: "fork.knife")
                        ).foregroundColor(tapFork ? Color("blueVilo") : .white)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(tapFork ? Color.white : Color("blueVilo"))
                            .clipShape(Circle())
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color("blueVilo"), style: StrokeStyle(lineWidth: 5))
                            )
                    }
                    Spacer()
                    Button(action: {
                        icon = .star
                        self.tapHeart = false
                        self.tapFork = false
                        self.tapStar = true
                        self.tapCart = false
                    }) {
                        Text(Image(systemName: "star.fill"))
                            .foregroundColor(tapStar ? Color("blueVilo") : .white)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(tapStar ? Color.white : Color("blueVilo"))
                            .clipShape(Circle())
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color("blueVilo"), style: StrokeStyle(lineWidth: 5))
                            )
                    }
                    Spacer()
                    Button(action: {
                        icon = .cart
                        self.tapHeart = false
                        self.tapFork = false
                        self.tapStar = false
                        self.tapCart = true
                    }) {
                        Text(Image(systemName: "cart"))
                            .foregroundColor(tapCart ? Color("blueVilo") : .white)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(tapCart ? Color.white : Color("blueVilo"))
                            .clipShape(Circle())
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color("blueVilo"), style: StrokeStyle(lineWidth: 5))
                            )
                    }
                    Spacer()
                }

            }.padding()
            
            Button(action: {
                // create a Place from name and address:
                let place = Place(name: name, address: address)
                // adding new favorite in user's favorites:
                user.favorites.append(Favorite(place: place, icon: icon))
                dump(user.favorites)
                
                // navigate back to home:
                favoriteBS.position = .hidden
                homeBS.position = .middle
                
                // erase textfields for next favorite:
                self.name = ""
                self.address = ""
                
            }) {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 140, height: 40)
                        .foregroundColor(Color("blueVilo"))
                    Text("AJOUTER")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 40)
            
            Spacer()
        }
    }
}

struct AddFavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMainView()
    }
}

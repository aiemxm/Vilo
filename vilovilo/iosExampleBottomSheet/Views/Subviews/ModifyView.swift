//
//  ModifyView.swift
//  pageFavori
//
//  Created by Giovanni Fioretto on 06/12/2021.
//

import SwiftUI

struct ModifyView: View {
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var icon: String = ""
    @State private var tapHeart = false
    @State private var tapFork = false
    @State private var tapStar = false
    @State private var tapCart = false
    var body: some View {
        NavigationView{
            VStack{
            Text("Nom")
                .font(.title2)
            
            TextField("nom du favori",text : $name)
                    .padding()
            Text("Addresse")
                .font(.title2)
            TextField("Barre de recherche",text : $address)
                    .padding()
            Text("Icone")
                .font(.title2)
            HStack{
                Spacer()
                Button(action: {
                    icon = "heart.fill"
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
                    icon = "fork.knife"
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
                    icon = "star.fill"
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
                    icon = "cart"
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
            Spacer()
                .frame(maxHeight: 100)
                HStack{
            Button(action: {}) {
                ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 140, height: 40)
                    .foregroundColor(Color("blueVilo"))
                Text("MODIFIER")
                    .foregroundColor(.white)
                }
            }
                    Button(action: {}) {
                        ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 140, height: 40)
                            .foregroundColor(Color("blueVilo"))
                        Text("SUPPRIMER")
                            .foregroundColor(.white)
                        }
                    }
            }
        }.navigationBarTitle(Text("Modifier un favori"))
        }
    }
}

struct ModifyView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyView()
    }
}

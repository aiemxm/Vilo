//
//  SearchView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI

struct RecentsView: View {
    
    @ObservedObject var profileBS = BottomSheetModel.profileBS
    
    @State private var queryString = ""
    @State private var searchPrompt = "Adresse"
    @State private var searches = [String]()
    @Binding var tap: Bool
    @Binding var choice: String

    
    let recentDestinations = [
        "12 rue de l'Etoile, 75015 Paris",
        "Papacionu - 7 rue Cadet, 75009 Paris",
        "71 rue de Bonne Nouvelle, 75011 Paris"
    ]
    
//    var suggestions: [String] {
//        // returns a collection of suggestions based on user input (queryString) using POI API
//        // dummy example:
//        if !queryString.isEmpty {
//            return ["12 rue de l'Etoile, 75015 Paris",
//                    "12 rue de Magenta, 75012 Paris",
//                    "12 rue de la Pierre Philosophale, 75016 Paris"]
//        }
//        return [String]()
//    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Récents")
                Spacer()
                Button("Tout voir", action: {})
            }
            
            Divider()
            
            VStack{
                if queryString.isEmpty {
                    ForEach(recentDestinations, id: \.self){ desti in
                        Button {
                            self.choice = desti
                            self.tap.toggle()
                            
                        } label: {
                            HStack{
                                Label(desti, systemImage: "clock")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }.padding()
                    }
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 4)
            
            Spacer()
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsView(tap: .constant(false), choice: .constant(""))
    }
}

//
//  ChooseAddressView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 09/12/2021.
//

import SwiftUI

struct ChooseAddressView: View {
    @State private var queryString = ""
    @State private var searchPrompt = "Adresse"
    @State private var searches = [String]()

    let recentDestinations = [
        "12 rue de l'Etoile, 75015 Paris",
        "299 boulevard Maillot, 75017 Paris",
        "71 rue de Bonne Nouvelle, 75011 Paris"
    ]
    
    var suggestions: [String] {
        // returns a collection of suggestions based on user input (queryString) using POI API
        // dummy example:
        if !queryString.isEmpty {
            return ["12 rue de l'Etoile, 75015 Paris",
                    "12 rue de Magenta, 75012 Paris",
                    "12 rue de la Pierre Philosophale, 75016 Paris"]
        }
        return [String]()
    }
    
    var body: some View {
        VStack{
            
            List(recentDestinations, id: \.self){ desti in
                if queryString.isEmpty {
//                    Button(desti) {
//                        searchPrompt = desti
//                        // and update Map centered around this address:
//                    }
                    Button {
                        searchPrompt = desti
                    } label: {
                        HStack{
                            Label(desti, systemImage: "clock")
                            Spacer()
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .listStyle(.grouped)
            Button("Définir") {
                Place.domicile.address = queryString
            }
            .buttonStyle(.borderedProminent)
            Text("queryString is: \(queryString)")
            
            
            
        }
        .navigationBarHidden(true)
        .searchable(text: $queryString, prompt: searchPrompt, suggestions: {
            if !queryString.isEmpty {
                // show suggestions/places from POI API as hint for result:
                ForEach(suggestions.filter { $0.localizedCaseInsensitiveContains(queryString) }, id: \.self){
                    Text($0)
                        .searchCompletion($0)
                }
            }
        })
        .onSubmit(of: .search) {
            // after search field submit, do that:
            print("submit")
            print(queryString)
            searches.insert(queryString, at: 0) // insert succesive searches in a collection
            //
        }
    }
}

struct ChooseAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseAddressView()
    }
}

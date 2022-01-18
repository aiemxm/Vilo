//
//  SearchBar.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI
import BottomSheet

struct SearchBar: View {
    @ObservedObject var viewModel : BottomSheetModel
    
    @FocusState private var isFocused: Bool
    
//    @Binding var text: String
    
    var body: some View {
        HStack {
            
            TextField("Ma position", text: $viewModel.destination)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if !viewModel.destination.isEmpty && isFocused {
                            Button(action: {
                                viewModel.destination = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .keyboardType(.default)
                .padding(.horizontal, 10)
                .focused($isFocused)
            
            if isFocused {
                Button(action: {
                    isFocused.toggle()
                    viewModel.destination = ""
                    viewModel.position = .middle

                }) {
                    Text("Annuler")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
//              .animation(.default) // original code
//                .animation(.easeIn(duration: 0.5), value: isFocused)
            }
        }
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(viewModel: .homeBS)
    }
}

//
//  SuggestionsView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct SuggestionsView: View {
    
    @ObservedObject var viewModel: BottomSheetModel
    
    @Binding var tap: Bool
    
    var body: some View {
        
        List(viewModel.results){ result in
            
            Button {
                viewModel.destination = result.subtitle
                viewModel.lat = result.lat
                viewModel.lon = result.lon
                tap.toggle()
            } label: {
                VStack(alignment: .leading) {
                    Text(result.title)
                    Text(result.subtitle)
                        .foregroundColor(.secondary)
                }
            }

            
        }
    }
}

struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView(viewModel: .homeBS, tap: .constant(false))
    }
}

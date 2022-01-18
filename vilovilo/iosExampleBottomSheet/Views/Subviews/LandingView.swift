//
//  LandingView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct LandingView: View {
    
    @Binding var destination: String
    
    var body: some View {
        
        VStack{
            
            BookmarksBlockView(destination: $destination)
            
            Divider()
            
            PreferencesBlockView()
            
            Spacer()
            
            BaladesView()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(destination: .constant(""))
    }
}

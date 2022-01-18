//
//  PreferencesBlockView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI

struct PreferencesBlockView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Préférences")
                Spacer()
                // Button("Tout voir", action: {})
            }
            
            Divider()
            
            VStack{
                Toggle("Vélo personnel", isOn: .constant(true))
                Toggle("Vélib", isOn: .constant(true))
                Toggle("Dott", isOn: .constant(true))
            }
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 4)
        }
        .padding()
    }
}

struct PreferencesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesBlockView()
    }
}

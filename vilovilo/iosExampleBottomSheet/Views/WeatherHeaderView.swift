//
//  WeatherHeaderView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct WeatherHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Météo du jour")
                .font(.title2)
            Text("Paris, France")
                .font(.caption)
        }
            
    }
}

struct WeatherHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHeaderView()
    }
}

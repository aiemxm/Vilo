//
//  SplashScreenView.swift
//  Vilo Mobil E Team
//
//  Created by Maxime Bégué on 14/12/2021.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var scale: CGFloat = 0.3
    var body: some View {
        VStack{
        if self.isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(colors: [Color("blueVilo"), Color("blueVilo"), Color("blueVilo2")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                Image("splash")
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        var animation: Animation {
                            Animation.easeInOut(duration: 3.5).repeatForever(autoreverses: true)
                        }

                        withAnimation(animation) {
                            scale = 1.3
                        }
                }
            }
        }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
    }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


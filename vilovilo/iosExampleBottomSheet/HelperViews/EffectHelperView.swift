//
//  EffectHelperView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI

struct EffectHelperView: UIViewRepresentable {
    
    var effect: UIVisualEffect
    
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: self.effect)
        
        return effectView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = self.effect
    }
}

struct EffectHelperView_Previews: PreviewProvider {
    static var previews: some View {
        EffectHelperView(effect: UIBlurEffect(style: .regular))
    }
}

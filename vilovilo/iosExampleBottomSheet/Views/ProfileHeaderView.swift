//
//  ProfileHeaderView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 10/12/2021.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel = BottomSheetModel.profileBS
    
    var body: some View {
        
        if viewModel.context == .profile {
            Text("Vos Paramètres")
                .font(.title2)
            //            .padding()
            
        }
        
        if viewModel.context == .search(type: .home) {
            
            HStack {
                Spacer()
                Text("Mon domicile")
                    .font(.title)
                Spacer()
            }
            .overlay {
                HStack{
                    Button {
                        viewModel.context = .profile
                        viewModel.position = .middle
                    } label: {
                        Image(systemName: "chevron.left.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("blueVilo"))
                            
                    }
                    Spacer()
                }
            }
            .padding()
        }
        
        if viewModel.context == .search(type: .office) {
            
            HStack {
                Spacer()
                Text("Mon travail")
                    .font(.title)
                Spacer()
            }
            .overlay {
                HStack{
                    Button {
                        viewModel.context = .profile
                        viewModel.position = .middle
                    } label: {
                        Image(systemName: "chevron.left.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("blueVilo"))
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}

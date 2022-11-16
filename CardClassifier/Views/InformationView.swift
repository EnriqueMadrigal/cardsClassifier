//
//  InformationView.swift
//  CardClassifier
//
//  Created by Algrthm on 15/11/22.
//

import Foundation
import SwiftUI


struct InformationView: View {
    
    var PokemonData: PokemonResult
    
    var body: some View {
        
        VStack{
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            
            HStack {
                
                Header3(text: "Pokemon:").frame(width: 80)
                Header3(text: PokemonData.pokemon)
                Spacer()
                
            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
            
            HStack {
                
                Header3(text: "Set:").frame(width: 80)
                Header3(text: PokemonData.set)
                Spacer()
                
            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
          
            HStack {
                
                Header3(text: "Rarity:").frame(width: 80)
                Header3(text: PokemonData.rarity)
                Spacer()
                
            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
          
            
          
            
        }.padding()
            
        
    }
}

/*
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(errorText: "Error")
    }
}
*/

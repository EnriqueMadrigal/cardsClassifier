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
    
    @StateObject var uploadModel = InformationViewModel()
    
    @StateObject var snapShotViewModel: SnapShotViewModel
    
    @State var imageResult: UIImage = UIImage()
    
    var body: some View {
        
        
        
        VStack{
            /*
            Image(systemName: "flag.2.crossed")
                .resizable()
                .frame(width: 64, height: 48, alignment: .center)
            */
            
            HStack {
                
                Header3(text: "Pokemon:").frame(width: 80).onAppear{
                    self.uploadModel.requestSetting = self.PokemonData
                }
                Header3(text: PokemonData.pokemon)
                Spacer()   .alert(item: $uploadModel.error){error in
                    Alert(title: Text("Message:"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")){
                        self.snapShotViewModel.PokemonData = nil
                    })
                    
                }
                
            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
            
            HStack {
                
                Header3(text: "Set:").frame(width: 80)
                Header3(text: PokemonData.set)
                Spacer()
                
            }.padding(.top,10).padding(.leading,20).padding(.trailing,20)
          
            HStack {
                
                Header3(text: "Rarity:").frame(width: 80)
                Header3(text: PokemonData.rarity)
                Spacer()
                
            }.padding(.top,10).padding(.leading,20).padding(.trailing,20)
          
            HStack{
                
                Header3(text: "Is Holo ?").frame(width: 60, alignment: .leading)
                CheckBoxView(checked: $uploadModel.isHolo){
                }
               Spacer()
                
                Header3(text: "Is Reverse ?").frame(width: 100, alignment: .leading)
                CheckBoxView(checked: $uploadModel.isReverse){
                }
                
                Spacer()
                
            }.padding(.top, 10).padding(.leading,20).padding(.trailing,20)
          
            Image(uiImage: self.imageResult)
                .resizable()
                .frame(width: 280, height: 340, alignment: .center).onAppear{
                    
                    
                    loadImageFromUrl(url: self.PokemonData.image_url) {(result: Result<UIImage?, ResultData.ResultError>) in
                        
                        switch result{
                            
                        case .success(let image?):
                            self.imageResult = image
                            
                        case .failure(let cur_error):
                            Alert(title: Text("Message:"), message: Text(cur_error.localizedDescription), dismissButton: .default(Text("OK")){
                                //self.snapShotViewModel.PokemonData = nil
                            })
                            
                        case .success(.none):
                            Alert(title: Text("Message:"), message: Text(ResultData.ResultError.failImageDonwload.localizedDescription), dismissButton: .default(Text("OK")){
                                //self.snapShotViewModel.PokemonData = nil
                            })
                        }
                        
                        
                    }
                    
                    
                }
            
            
            
            Header2(text: "It is correct ?").padding(.top,20)
            
            HStack{
                
                NegativeAnswer(){
                    self.uploadModel.isCorrect = false
                    self.uploadModel.uploadResult()
                }
                
                Spacer()
                
                PositiveAnswer()
                {
                    self.uploadModel.isCorrect = true
                    self.uploadModel.uploadResult()
                }
                
            }.padding(.leading,20).padding(.trailing,20).padding(.top,20)
            
            
            Spacer()
            
        }.padding()
            
        
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(PokemonData: PokemonResult(pokemon: "", set: "", rarity: "", poke_id: "", image_url: "", request_id: ""), snapShotViewModel: SnapShotViewModel())
    }
}


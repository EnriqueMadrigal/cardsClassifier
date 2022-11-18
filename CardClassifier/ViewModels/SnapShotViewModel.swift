//
//  SnapShotViewModel.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import UIKit


class SnapShotViewModel: NSObject, ObservableObject{
 
    @Published var error: ResultData.ResultError?
    @Published var currentImage: UIImage? = nil
    @Published var showProgressView = false
    
    @Published var PokemonData: PokemonResult?
    
    @Published var isCamera: Bool = true
    
    let customQueue: DispatchQueue = DispatchQueue(label: "saveDataQueue")
    
    func uploadFile()
    {
        
        if let currentImage = currentImage {
            
            //Upload image to server
            DispatchQueue.main.async {
        
                    self.showProgressView = true
                
                var resultData: Any?
                
                    uploadImageToServer(imageData: currentImage){(result: Result<Data?, ResultData.ResultError>) in
                        self.showProgressView = false
                        
                        
                        
                        switch result{
                            
                        case .success(let data?):
                            print(data)
                            resultData = data
                            ///////
                            
                            let currentData = String(data: data , encoding: .utf8)
                            
                            if let data = currentData?.data(using: .utf8){
                                 
                                do {
                                    
                                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:String]
                                    //let jsonData = try JSONSerialization.data(withJSONObject: currentData)
                                    
                                    //print (jsonData)
                                    
                                    self.PokemonData = PokemonResult(pokemon: "", set: "", rarity: "", poke_id: "", image_url: "", request_id: "")
                                    
                                    if let pokemon = jsonData?["pokemon"]{
                                        self.PokemonData?.pokemon = pokemon
                                    }
                                   
                                    if let customData = jsonData?["set"]{
                                        self.PokemonData?.set = customData
                                    }
                                    
                                    if let customData = jsonData?["rarity"]{
                                        self.PokemonData?.rarity = customData
                                    }

                                    if let customData = jsonData?["poke_id"]{
                                        self.PokemonData?.poke_id = customData
                                    }

                                    if let customData = jsonData?["image_url"]{
                                        self.PokemonData?.image_url = customData
                                    }

                                    if let customData = jsonData?["request_id"]{
                                        self.PokemonData?.request_id = customData
                                        
                                    }

                                 
                                    
                                }
                                
                                catch {
                                    print(error.localizedDescription.description)
                                }
                                
                                
                            }
                            
              
                            
                            
                            
                            ///////
                            break
                            
                        case .failure(let cur_error):
                            self.error = cur_error
                            
                        case .success(.none):
                            break
                        }
                    }
             
                
                self.currentImage = nil
            }
            
            
        }
        else
        {
            self.error = ResultData.ResultError.noImageSelected
        }
        
        
    }
    
    
    func testData()
    {
        
        let currentData = "{\"pokemon\":\"Fighting Energy\",\"set\":\"Expedition Base Set\",\"rarity\":\"Common\",\"poke_id\":\"ecard1-160\",\"image_url\":\"https://storage.googleapis.com/pokesearch/images/ecard1-160.png?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=terraform-sa%40temporal-bebop-343615.iam.gserviceaccount.com%2F20221115%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221115T191538Z&X-Goog-Expires=900&X-Goog-SignedHeaders=host&X-Goog-Signature=87658ba085653721c74cc9607a88b96121ce5848d6ea7710adf233151d03993d881eb700311120bdb015e4112bd0b00fd592265d60928d121d3917c737229ecc2a538b8a00e8b10f229992d6b64a0d5141a2bd700917674a8856b32c54d2dd07b615d3b7046519a080ddadb8729c0f0d416ff719c8de653af576724175c4134c962f51cc2914bc14a76c79907caa9150750e072accda8c1d7093b47021f1e97febc0a8da673c3f4c958614e37f46ce9fc5f159dd74d2608adf4b74f71af99496450af417c93140f7ef5c2112a67113da1d9ab5b8c2a76915aeb4cf77090774a1660ef1ab9fde011cafe526d48ea23cbe66ce520c1b887ff4a6f0cd6c4ab6a5cc\",\"request_id\":\"92e22df9-1df1-4de9-840e-509daa2f72fa\"}"
     
        
       
        if let data = currentData.data(using: .utf8){
             
            do {
                
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:String]
                //let jsonData = try JSONSerialization.data(withJSONObject: currentData)
                
                //print (jsonData)
                
                self.PokemonData = PokemonResult(pokemon: "", set: "", rarity: "", poke_id: "", image_url: "", request_id: "")
                
                if let pokemon = jsonData?["pokemon"]{
                    self.PokemonData?.pokemon = pokemon
                }
               
                if let customData = jsonData?["set"]{
                    self.PokemonData?.set = customData
                }
                
                if let customData = jsonData?["rarity"]{
                    self.PokemonData?.rarity = customData
                }

                if let customData = jsonData?["poke_id"]{
                    self.PokemonData?.poke_id = customData
                }

                if let customData = jsonData?["image_url"]{
                    self.PokemonData?.image_url = customData
                }

                if let customData = jsonData?["request_id"]{
                    self.PokemonData?.request_id = customData
                    
                }

             
                
            }
            
            catch {
                print(error.localizedDescription.description)
            }
            
            
        }
        
        
    }
    
    
}

//
//  InformationViewModel.swift
//  CardClassifier
//
//  Created by Algrthm on 17/11/22.
//

import Foundation

class InformationViewModel: ObservableObject
{
    
    @Published var isHolo = false
    @Published var isReverse = false
    
    @Published var isCorrect = true
    @Published var request_id: String = ""
    
    @Published var requestSetting: PokemonResult?
    @Published var error: ResultData.ResultError?
    
    
    init()
    {
        
        
    }
    
    
    func uploadResult()
    {
        
        if let requestSetting = requestSetting {
            
            uploadResultData(request_id: requestSetting.request_id, correct: self.isCorrect, is_holo: self.isHolo, is_reverse: self.isReverse) {(result: Result<Data?, ResultData.ResultError>) in
                // self.showProgressView = false
                
                switch result{
                    
                case .success( _?):
                    //print(data)
                    self.error = ResultData.ResultError.noerror
                    break
                    
                case .failure(let cur_error):
                    self.error = cur_error
                    
                case .success(.none):
                    break
                }
            }
            
            
        }
        
        
    }
    
}


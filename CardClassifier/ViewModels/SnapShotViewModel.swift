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
    
    let customQueue: DispatchQueue = DispatchQueue(label: "saveDataQueue")
    
    func uploadFile()
    {
        
        if let currentImage = currentImage {
            
            //Upload image to server
            customQueue.async {
        
                    self.showProgressView = true
                    uploadImageToServer(imageData: currentImage){(result: Result<Data?, ResultData.ResultError>) in
                        self.showProgressView = false
                        
                        switch result{
                            
                        case .success(let data?):
                            print(data)
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
    
    
}

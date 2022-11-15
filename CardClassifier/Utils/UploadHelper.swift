//
//  UploadHelper.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import UIKit
import Alamofire



func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


func saveLocalImage(image: UIImage)-> URL{
    var filename: URL = URL(fileURLWithPath: "")
    
    if let data = image.jpegData(compressionQuality: 0.8) {
            filename = getDocumentsDirectory().appendingPathComponent("copy.jpg")
           try? data.write(to: filename)
       }
    
    return filename
}

func uploadImageToServer(imageData: UIImage, completation: @escaping (Result<Data?, ResultData.ResultError>) -> Void)
{

    let headers : Alamofire.HTTPHeaders = [
               "cache-control" : "no-cache",
               "Accept-Language" : "en",
               "Connection" : "close",
               "x-token": Common.token,
               "accept": "application/json"
           ]
    
    let urlString = Common.api_url + "pokesearch_url"
 
    
    AF.upload(multipartFormData: { (formData) in
                            
               //for post image
               guard let imageData = imageData.jpegData(compressionQuality: 0.8) else {return}
        formData.append(imageData, withName:"file", fileName:"image.jpg", mimeType: "image/jpg")
        
        //formData.append(Data(file_type.utf8), withName: "file_type")
        //formData.append(Data(exp_group_id.utf8), withName: "exp_group_id")
        //formData.append(Data(exp_id.utf8), withName: "exp_id")
               
    }, to: urlString, method: .post, headers: headers).uploadProgress(queue: .main) { (progress) in
               print("Upload progress: \(progress.fractionCompleted)")
           }.response { (dataResp) in
               switch dataResp.result{
               case .failure(let err):
                   print("Failed to hit server:", err)
                   completation(.failure(.failedUpload))
                   break
                   
               case .success:
                   if let code = dataResp.response?.statusCode,code >= 300 {
                       print("Failed to upload with status: ", code)
                       completation(.failure(.failedUpload))
                       //return
                   }
                   let respString = String(data: dataResp.data ?? Data(), encoding: .utf8)
                   print("Successfully created post, here is the response:")
                   print(respString ?? "")
                   completation(.success(dataResp.data))
                  // self.fetchPosts()
               }
       
           }
    
}


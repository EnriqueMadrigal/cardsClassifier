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
    
    let urlString = Common.api_url + "pokesearch"
 
    
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

func uploadResultData(request_id: String, correct: Bool, is_holo: Bool, is_reverse: Bool,completation: @escaping (Result<Data?, ResultData.ResultError>) -> Void)
{
    let urlString = Common.api_url + "classification-data"
    
    let headers : Alamofire.HTTPHeaders = [
        "cache-control" : "no-cache",
        "Accept-Language" : "en",
        "Connection" : "close",
        "x-token": Common.token,
        "accept": "application/json"
    ]
    
    //let experiment_id = UUID().uuidString
    
    let data_params = ClassificationPostData(classification_request_id: request_id, correct: correct, is_holo: is_holo, is_reverse: is_reverse)
    
    
    // encoding: URLEncoding.httpBody,
    AF.request(urlString, method: .post,parameters: data_params, encoder: JSONParameterEncoder.default ,headers: headers).validate(statusCode: 200 ..< 502).responseData {response in
        
        let statusCode = response.response?.statusCode
        
        switch response.result{
        case .success(_):
            switch statusCode {
            case 200:
                completation(.success(response.data))
                
            default:
                completation(.failure(.datafailedUpload))
            }
            
            
        case .failure(let error):
            print(error)
            completation(.failure(.datafailedUpload))
            
        }
        
    }
    
}
    
    
    
func loadImageFromUrl(url: String, completation: @escaping (Result<UIImage?, ResultData.ResultError>)-> Void)
{
        
        
        AF.request(url,method: .get).response{ response in

           switch response.result {
            case .success(let responseData):
                let return_image =  UIImage(data: responseData!, scale:1)
               completation(.success(return_image))
               //return return_image
               
            case .failure(let error):
                print("error--->",error)
               completation(.failure(.failImageDonwload))
               
            }
        
        
        //return nil
    }
    
}


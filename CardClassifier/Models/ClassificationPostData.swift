//
//  ClassificationPostData.swift
//  CardClassifier
//
//  Created by Algrthm on 17/11/22.
//

import Foundation


struct ClassificationPostData : Codable{
    
    var classification_request_id: String
    var correct: Bool
    var is_holo: Bool
    var is_reverse: Bool
    
}

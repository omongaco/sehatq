//
//  APIService.swift
//  sehatqmart
//
//  Created by Ansyar Hafid on 7/1/20.
//  Copyright © 2020 Hafid. All rights reserved.
//

import UIKit
import Alamofire

class APIService {
    
    static func getHomeObjects(completion: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        AF.request(homeApi).responseJSON { result in
            if let statusCode = result.response?.statusCode {
                if statusCode > 201 {
                    let localizedError = NSError(domain: "com.Anchorock.ErrorDomain", code: statusCode, userInfo: [NSLocalizedDescriptionKey:"StatusError"])
                    completion(nil, localizedError)
                } else {
                    completion(result.data, nil)
                }
            }
        }
    }
    
    static func getImage(withUrl url: String, completion: @escaping(_ image: UIImage?, _ error: Error?) -> Void) {
        AF.download(url).responseData { response in
            if response.error != nil {
                completion(nil, response.error)
            } else {
                if let data = response.value {
                    let image = UIImage(data: data)
                    completion(image, nil)
                }
            }
        }
    }
    
}

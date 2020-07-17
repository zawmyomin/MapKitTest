//
//  APIClient.swift
//  Test
//
//  Created by Justin Zaw on 24/04/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    
    static let shared = APIClient()
    
    func getDatalist(url: String,completion: @escaping (JSON, Int) -> Void){
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData{ (response) in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                let json = JSON(response.result.value!)
                completion(json, statusCode!)
            }else{
                completion(JSON.null, statusCode!)
            }
        }
    }
    
    
//    func getSearchData(keyword: String,completion: @escaping (JSON, Int) -> Void){
//        
//    //    let url = " http://api.themoviedb.org/3/search/person?api_key=db85bc6bf1d96e2f47ac91af80e1d717&query=\(keyword)"
//       
//        
//        let url = "https://api.themoviedb.org/3/search/movie?api_key=db85bc6bf1d96e2f47ac91af80e1d717&language=en-US&query=\(keyword)&page=1&include_adult=false"
//        let escapedURL = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
//        Alamofire.request(escapedURL!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData{ (response) in
//                   let statusCode = response.response?.statusCode
//                   if statusCode == 200 {
//                       let json = JSON(response.result.value!)
//                       completion(json, statusCode!)
//                   }else{
//                       completion(JSON.null, statusCode!)
//                   }
//               }
//        
//           }
    
    
    
}



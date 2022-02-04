//
//  WebService.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import Foundation
import Alamofire


class NewWebService {
    enum CustomError:Error {
        case invalidUrl
        case invalidData
    }
    
    func requestUrl<T: Codable>(
    url:URL?,
    parameters:Parameters,
    expecting:T.Type,
    completion: @escaping(Result<T,Error>) -> Void)    {
        
        guard let url = url else{
            completion(.failure(CustomError.invalidUrl))
            return
        }
       AF.request(url, method: .get, parameters: parameters).responseData(){ response in
            if let data = response.data {
                do{
                    let results = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(results))
                }
                catch{
                    completion(.failure(error))
                }
            }
                
        }
    }
}

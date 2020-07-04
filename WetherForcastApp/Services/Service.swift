//
//  Service.swift
//  WetherForcastApp
//
//  Created by Vikash on 29/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    
    func GetData(urlString: String, dispatchGroup:DispatchGroup? = nil, complitionHandler:@escaping (Any)-> Void) {
        
        dispatchGroup?.enter()
        guard let url = URL(string: urlString)
            else {
                return
        }
        
        Alamofire.request(url, method: .get, parameters: [:]).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            guard let value = response.result.value as? [String:Any] else {
                return
            }
            dispatchGroup?.leave()
            complitionHandler(value)
        }
    }
    
    
    /*
    func GetData(urlString: String, dispatchGroup:DispatchGroup? = nil, complitionHandler:@escaping (Any)-> Void) {
        
        dispatchGroup?.enter()
        guard let url = URL(string: urlString)
            else {
                return
        }
        
        DispatchQueue.global().async { [weak self] in
        if let data = try? Data(contentsOf: url) {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    self?.viewModel.jsonResponse(response: json)
                    complitionHandler(json)
                    dispatchGroup?.leave()
                }
            }
        }
    }
    */
}

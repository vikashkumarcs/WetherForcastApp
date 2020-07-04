//
//  DataMaping.swift
//  WetherForcastApp
//
//  Created by Vikash on 30/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation

class DataMaping {
    
    func mappingData(item: [String:Any], cellInfo: inout Step1CellModel) {
        
        let json = item
        if let weather = json["weather"] as? [Any],
            let dateArray = weather[0] as? [String:Any] {
            
            let desc = dateArray["description"] as? String
            cellInfo.wetherDescription = desc ?? "NA"
            print(desc ?? "NA")
        }
        
        if let main = json["main"] as? [String:Any] {
            if let minTemp = main["temp_min"] {
                cellInfo.minTemp = minTemp as? Double
                print(minTemp)
            }

            if let maxTemp = main["temp_max"] {
                cellInfo.maxTemp = maxTemp as? Double
                print(maxTemp)
            }
        }

        if let wind = json["wind"] as? [String:Any] {
            if let windSpeed = wind["speed"] {
                cellInfo.windSpeed = windSpeed as? Double
                print(windSpeed)
            }
        }
    }
}

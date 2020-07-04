//
//  AppConstant.swift
//  WetherForcastApp
//
//  Created by Vikash on 29/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation

struct APIConstant {
    
    static let key = "e26f3bd7ce6442eb9bffd7228043997b"
    static let BASE_URL1 = "https://api.openweathermap.org/data/2.5/weather?q="
    static let BASE_URL = "https://api.openweathermap.org/data/2.5/"
    static let appid = "&appid="
    static let weather = "weather?q="
    static let forcast = "forecast?"
    static let latitude = "lat="
    static let logitude = "&lon="
}

struct AppConstant {
    static let MinNumberCity = 3
    static let MaxNumberCity = 7
}

struct CellConstant {
    static let cell1Id = "Step1TableViewCellId"
    static let cell2Id = "Step2TableViewCellId"
}

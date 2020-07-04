//
//  Step1ViewModel.swift
//  WetherForcastApp
//
//  Created by Vikash on 29/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import Alamofire

class Step1ViewModel {
    
    var model = CityModel()
    private var dataMaping:DataMaping
    private let restService: APIService
    
    var reloadTableViewClosure: (()->())?
    public private(set) var dataSource: [Step1CellModel] = [Step1CellModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    public private(set) var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    init(services:APIService, dataMaping: DataMaping) {
        self.restService = services
        self.dataMaping = dataMaping
    }
    
    func requestedCitiesName(cities: String) {
        model.citiesName = cities
        checkMinAndMaxCityCondition()
    }
    
    private func checkMinAndMaxCityCondition() {
        
        if let collection = model.citiesName {
            
            let cities = collection.components(separatedBy: ",").map {
                $0.trimmingCharacters(in: .whitespaces)
            }
            
            if !cities.isEmpty && cities.count >= AppConstant.MinNumberCity &&
                cities.count <= AppConstant.MaxNumberCity {
                if Connectivity.isConnectedToInternet {
                    fetchDataFromAPI(cities: cities)
                } else {
                    self.alertMessage = "Internet isn't available"
                }
            }
            else {
                self.alertMessage = "Please provide minimum 3 city name and maximum 7 city name"
            }
        }
    }
    
    // call to API
    func fetchDataFromAPI(cities:[Any]) {
        
        let myGroup = DispatchGroup()
        var collection = [Step1CellModel]()
        
        for city in cities {
            let urlString = "\(APIConstant.BASE_URL)\(APIConstant.weather)\(city)\(APIConstant.appid)\(APIConstant.key)"
            self.restService.GetData(urlString: urlString, dispatchGroup: myGroup, complitionHandler: { response in
                guard let json = response as?  [String: Any] else { return  }
                var cellInfo = Step1CellModel()
                self.dataMaping.mappingData(item: json, cellInfo: &cellInfo)
                collection.append(cellInfo)
            })
        }
        
        myGroup.notify(queue: .main) {
            print("Finished all requests.")
            self.dataSource.removeAll()
            self.dataSource = collection
        }
    }
}



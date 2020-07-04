//
//  Step2ViewModel.swift
//  WetherForcastApp
//
//  Created by Vikash on 30/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate:NSObjectProtocol {
    func currentLocationCoordiane(location:CLLocationCoordinate2D)
}

class Step2ViewModel: NSObject {
    
    private var currentlocation:CLLocationCoordinate2D?
    private var dataMaping:DataMaping
    private var location = LocationService()
    private let restService: APIService
    
    var reloadTableViewClosure: (()->())?
    public private(set) var dataSource: [Step1CellModel] = [Step1CellModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    init(services:APIService, dataMaping: DataMaping) {
        self.restService = services
        self.dataMaping = dataMaping
    }
    
    func getCurrentlocation() {
        location.setViewDelegate(selfViewDelegate: self)
        location.checklocationService()
    }
    
    func fetchData() {
        if let currentlocation = currentlocation {
            let urlString = "\(APIConstant.BASE_URL)\(APIConstant.forcast)\(APIConstant.latitude)\(currentlocation.latitude)\(APIConstant.logitude)\(currentlocation.longitude)\(APIConstant.appid)\(APIConstant.key)"
            
            self.restService.GetData(urlString: urlString) { (response) in
                print(response)
                guard let json = response as?  [String: Any] else { return  }
                if let list = json["list"] as? [Any] {                    
                    for item in list {
                        if let json = item as? [String:Any] {
                            var cellInfo = Step1CellModel()
                            self.dataMaping.mappingData(item: json, cellInfo: &cellInfo)
                            self.dataSource.append(cellInfo)
                        }
                    }
                }
            }
        }
    }
}

extension Step2ViewModel:LocationServiceDelegate {
    func currentLocationCoordiane(location: CLLocationCoordinate2D) {
        self.currentlocation = location
        fetchData()
    }
}

class LocationService:NSObject {
    
    private var locationManager = CLLocationManager()
    weak var locationServiceDelegate:LocationServiceDelegate?
    
    func setViewDelegate(selfViewDelegate: LocationServiceDelegate?) {
        self.locationServiceDelegate = selfViewDelegate
    }
    
    func checklocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            print("Please enable setting location")
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() {
        
        guard let location = locationManager.location?.coordinate else {
            print("latitude, longitude are not available!")
            return
        }
        self.locationServiceDelegate?.currentLocationCoordiane(location: location)
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            getCurrentLocation()
            break
            
        case .denied:
            break
            
        case .notDetermined:
            break
            
        case .restricted:
            break
            
        case .authorizedAlways:
            getCurrentLocation()
            break
        @unknown default: break
            
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

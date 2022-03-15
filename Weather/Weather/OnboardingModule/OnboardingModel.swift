//
//  OnboardingModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 01.02.2022.
//

import Foundation
import CoreLocation

final class OnboardingModel: NSObject {
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    var dataManager: DataManager?
    var callBack: (() -> Void)?
    
    private let locationManager = CLLocationManager()
    
    func locationRequest() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func render(location: CLLocation) {
                    
        self.dataManager?.addLocationCity(lat: Float(location.coordinate.latitude),
                                         lon: Float(location.coordinate.longitude))
            
        self.callBack?()
            
    }
    
}

extension OnboardingModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            manager.stopUpdatingLocation()
            
            self.render(location: location)
            
        }
        
    }
    
}

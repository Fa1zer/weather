//
//  TwentyFourHoursWeatherViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 05.02.2022.
//

import Foundation

final class TwentyFourHoursWeatherViewModel: Coordinatable {
    
    init(dataManager: DataManager) {
        
        self.model.dataManager = dataManager
        
    }
    
    var appCoordinator: AppCoordinator?
    
    var callBack: (() -> Void)? {
        
        didSet {
            
            self.model.callBack = self.callBack
            
        }
        
    }
    
    private let model = TwentyFourHoursWeatherModel()
    private let userDefaults = UserDefaults.standard
    
    func popToHomepageController() {
        self.appCoordinator?.popViewController()
    }
    
    func getTwentyFourHoursWeather(index: Int) -> [TwentyFourHoursWeather] {
        return self.model.twentyFourHoursWeatherRequest(index: index)
    }
    
    func getCityNames(index: Int) -> String {
        return self.model.cityName(index: index)
    }
    
    func isMetric() -> Bool {
        return self.userDefaults.string(forKey: "speed") == "Km" ? true : false
    }
    
}

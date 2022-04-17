//
//  TwentyFiveViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 14.02.2022.
//

import Foundation

final class TwentyFiveDaysViewModel: Coordinatable {
    
    init(dataManager: DataManager) {
        
        self.model.dataManager = dataManager
        
    }
    
    var appCoordinator: AppCoordinator?
    var callBack: (() -> Void)?
    
    private let model = TwentyFiveDaysModel()
    private let userDefaults = UserDefaults.standard
    
    func isMetric() -> Bool {
        return self.userDefaults.string(forKey: "speed") == "Km" ? true : false
    }
    
    func allWeatherCount() -> Int {
        return self.model.allWeatherCount()
    }
    
    func popToHomepageController() {
        self.appCoordinator?.popViewController()
    }
    
    func getDatesCount(index: Int) -> Int {
        return self.model.datesCount(index: index)
    }
    
    func getCityNames(index: Int) -> String {
        return self.model.cityName(index: index)
    }
    
    func getAllDates(index: Int, secondIndex: Int) -> String {
        return self.model.allDatasRequest(index: index, secondIndex: secondIndex)
    }
    
    func getAllWeather(index: Int, secondIndex: Int) -> [TwentyFiveDaysWeather] {
        return self.model.twentyFiveDaysWeather(index: index, secondIndex: secondIndex)
    }
    
    func getSunsetSunrise(index: Int, secondIndex: Int) -> SunsetSinrise {
        return self.model.sunsetSunriseRequest(index: index, secondIndex: secondIndex)
    }
    
    func getAirPoints(index: Int, secondIndex: Int) -> Int {
        return self.model.airPointsRequest(index: index, secondIndex: secondIndex)
    }
    
}

//
//  HomepageViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 02.02.2022.
//

import Foundation

final class HomepageViewModel: Coordinatable {
    
    init(dataManager: DataManager) {
        
        self.model.dataManager = dataManager
        
    }
    
    var appCoordinator: AppCoordinator?
    
    var callBack: (() -> Void)? {
        
        didSet {
            
            self.model.callBack = callBack

        }
        
    }
    
    private let model = HomepageModel()
    private let userDefaults = UserDefaults.standard
    
    func getCitysCount() -> Int {
        return self.model.citysCount()
    }
    
    func isMetric() -> Bool {
        return self.userDefaults.string(forKey: "speed") == "Km" ? true : false
    }
    
    func getCityNames(index: Int) -> String {
        return self.model.cityName(index: index)
    }
    
    func getTwentyFourHoursWeather(index: Int) -> [OneHourWeather] {
        return self.model.twentyFourHoursWeatherRequest(index: index)
    }
    
    func getTwentyFiveDaysWeather(index: Int) -> [OneDayWeather] {
        return self.model.twentyFiveDaysWeatherRequest(index: index)
    }
    
    func getInformationData(index: Int) -> InformationData {
        return self.model.informationWeatherRequest(index: index)
    }
    
    func pushTwentyFourHours(index: Int) {
        self.appCoordinator?.goToTwentyFourHours(index: index)
    }
    
    func pushTwentyFiveDays(index: Int, dateIndex: Int) {        
        self.appCoordinator?.goToTwentyFiveDays(index: index, dateIndex: dateIndex)
    }
    
    func openSetting() {
        self.appCoordinator?.goToSettings()
    }
    
    func addCity(cityNamed: String) {
        
        DispatchQueue.main.async { [ weak self ] in
            
            guard var citys = self?.userDefaults.object(forKey: "citys") as? [String]? else { return }
            
            if citys == nil { citys = [] }
            
            citys?.append(cityNamed)
            
            citys = citys?.sorted { $0 != $1 }
            
            self?.userDefaults.set(citys, forKey: "citys")
            
            self?.model.newCityDataRequest()
            
        }
        
    }
    
}

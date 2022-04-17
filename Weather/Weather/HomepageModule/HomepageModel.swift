//
//  HomepageModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 02.02.2022.
//

import Foundation

final class HomepageModel {
    
    var dataManager: DataManager?
    
    var callBack: (() -> Void)? {
        
        didSet {
                        
            self.dataManager?.callBack = callBack
            
        }
        
    }
    
    func informationWeatherRequest(index: Int) -> InformationData {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return InformationData(
            lowlestGraduation: 0,
            bigestGraduation: 0,
            nowGraduation: 0,
            text: "none",
            sunriseTime: "none",
            sunsetTime: "none",
            number: 0,
            windSpeed: 0,
            humidityProcent: 0,
            informaton: "none"
        ) }
        
        return self.dataManager?.allWeather[index].information ?? InformationData(
            lowlestGraduation: 0,
            bigestGraduation: 0,
            nowGraduation: 0,
            text: "none",
            sunriseTime: "none",
            sunsetTime: "none",
            number: 0,
            windSpeed: 0,
            humidityProcent: 0,
            informaton: "none"
        )
        
    }
    
    func twentyFiveDaysWeatherRequest(index: Int) -> [OneDayWeather] {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return [] }
        
        return self.dataManager?.allWeather[index].oneDayWeather ?? []
        
    }
    
    func twentyFourHoursWeatherRequest(index: Int) -> [OneHourWeather] {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return [] }
        
        return self.dataManager?.allWeather[index].oneHourWeather ?? []
        
    }
    
    func cityName(index: Int) -> String {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return "" }
        
        return self.dataManager?.allWeather[index].cityName ?? ""
        
    }
    
    func citysCount() -> Int {
        return self.dataManager?.allWeather.count ?? 0
    }
    
    func newCityDataRequest() {
        self.dataManager?.homepageWeatherRequest()
    }
    
}

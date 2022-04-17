//
//  TwentyFiveModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 14.02.2022.
//

import Foundation

final class TwentyFiveDaysModel {
    
    var dataManager: DataManager?
    var callBack: (() -> Void)?
        
    func allDatasRequest(index: Int, secondIndex: Int) -> String {
        return self.dataManager?.allWeather[index].twentyFiveDaysWeather[secondIndex].time ?? "none"
    }
    
    func twentyFiveDaysWeather(index: Int, secondIndex: Int) -> [TwentyFiveDaysWeather] {
        
        if (self.dataManager?.allWeather.count ?? 0) - 1 < index ||
            (self.dataManager?.allWeather[index].twentyFiveDaysWeather.count ?? 0) - 1 < secondIndex {
            return []
        }
        
        return self.dataManager?.allWeather[index].twentyFiveDaysWeather[secondIndex].weather ?? []
        
    }
    
    func sunsetSunriseRequest(index: Int, secondIndex: Int) -> SunsetSinrise {
        
        if (self.dataManager?.allWeather.count ?? 0) - 1 < index ||
            (self.dataManager?.allWeather[index].twentyFiveDaysWeather.count ?? 0) - 1 < secondIndex {
            return SunsetSinrise(sunriseTime: "none", sunsetTime: "none", sun: "none", moon: "none")
        }
        
        return self.dataManager?.allWeather[index].twentyFiveDaysWeather[secondIndex].sunriseSunset ??
        SunsetSinrise(sunriseTime: "none", sunsetTime: "none", sun: "none", moon: "none")
    }
    
    func airPointsRequest(index: Int, secondIndex: Int) -> Int {
        
        if (self.dataManager?.allWeather.count ?? 0) - 1 < index ||
            (self.dataManager?.allWeather[index].twentyFiveDaysWeather.count ?? 0) - 1 < secondIndex {
            return 0
        }
        
        return self.dataManager?.allWeather[index].twentyFiveDaysWeather[secondIndex].airPoints ?? 0
    }
    
    func cityName(index: Int) -> String {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return "none" }
        
        return self.dataManager?.allWeather[index].cityName ?? "none"
        
    }
    
    func datesCount(index: Int) -> Int {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return 0 }
        
        return self.dataManager?.allWeather[index].twentyFiveDaysWeather.count ?? 0
        
    }
    
    func allWeatherCount() -> Int {
        return self.dataManager?.allWeather.count ?? 0
    }
        
}

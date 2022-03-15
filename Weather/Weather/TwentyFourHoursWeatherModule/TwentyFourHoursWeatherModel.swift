//
//  TwentyFourHoursWeatherModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 05.02.2022.
//

import Foundation

final class TwentyFourHoursWeatherModel {
    
    var dataManager: DataManager?
    var callBack: (() -> Void)?
    
    func twentyFourHoursWeatherRequest(index: Int) -> [TwentyFourHoursWeather] {
        
        return dataManager?.allWeather[index].twentyFourHoursWeather ?? []
        
    }
    
    func cityName(index: Int) -> String {
        
        if index > ((self.dataManager?.allWeather.count ?? 0) - 1) || index < 0 { return "none" }
        
        return self.dataManager?.allWeather[index].cityName ?? "none"
        
    }
    
}

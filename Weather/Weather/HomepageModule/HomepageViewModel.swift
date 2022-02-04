//
//  HomepageViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 02.02.2022.
//

import UIKit

final class HomepageViewModel: Coordinatable {
    
    var appCoordinator: AppCoordinator?
    
    private let model = HomepageModel()
    private var twentyFourHoursWeather = [OneHourWeather(time: "12:00", graduation: 13, weather: "Frame")]
    private var twentyFiveDayWether = [OneDayWeather(date: "17/04",
                                                     humidityImage: "Frame-3",
                                                     humidityProcent: 57,
                                                     graduationsDifference: "4°-11°",
                                                     information: "Преймущественно облачно")]
    
    func getTwentyFourHoursWeather() -> [OneHourWeather] {
        return twentyFourHoursWeather
    }
    
    func getTwentyFiveDaysWeather() -> [OneDayWeather] {
        return twentyFiveDayWether
    }
    
    func pushTwentyFourHours() {
        appCoordinator?.goToTwentyFourHours()
    }
    
    func openTwentyFiveDays() {
        print(#function)
    }
    
    func pushOneHourInformation() {
        appCoordinator?.goToOneHourInformation()
    }
    
}

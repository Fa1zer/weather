//
//  DataManager.swift
//  Weather
//
//  Created by Artemiy Zuzin on 27.02.2022.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift
import SwiftUI

final class DataManager {
    
    init() {
        guard let realm = self.realm else { return }
        
        for data in realm.objects(Weather.self) {
            self.getAllCache(data: data.allWeather, name: data.name)
        }
    }
    
    private let realm = try? Realm()
    private let urlConstructor = URLConstructor.standart
    private let userDefaults = UserDefaults.standard
    
    var callBack: (() -> Void)?
    
    
    var allWeather = [(information: InformationData,
                       oneDayWeather: [OneDayWeather],
                       oneHourWeather: [OneHourWeather],
                       twentyFourHoursWeather: [TwentyFourHoursWeather],
                       twentyFiveDaysWeather: [(weather: [TwentyFiveDaysWeather],
                                                sunriseSunset: SunsetSinrise,
                                                time: String,
                                                airPoints: Int)],
                       cityName: String)]() {
        
        didSet {
            
            self.callBack?()
            
        }
        
    }
    
    func homepageWeatherRequest() {
        
        guard let citys = userDefaults.object(forKey: "citys") as? [String]? else { return }
                        
        DispatchQueue.global().async { [ weak self ] in
            
            guard let self = self else { return }
            
            self.allWeather = []
            
            for city in citys ?? [] {
                
                Alamofire.request(self.urlConstructor.geocoderURL(geocode: city)).validate()
                    .responseJSON { response in
                    
                        if let error = response.error {
                            print(error.localizedDescription)
                        
                            return
                        }
                    
                        guard let data = response.data else {
                            print("error: data is equal to nil")
                        
                            return
                        }
                        
                        guard let pos = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                              let coord = pos["coord"] as? [String : Any],
                              let lon = coord["lon"] as? Double,
                              let lat = coord["lat"] as? Double,
                              let name = pos["name"] as? String else { return }
                                                                
                        self.getInfomationWeather(lat: Float(lat), lon: Float(lon), name: name)
                    
                    }.resume()
                
            }
            
        }
        
    }
    
    private func getInfomationWeather(lat: Float, lon: Float, name: String) {
        
        let isTwentyFourFormate = self.userDefaults.integer(forKey: "time") == 24 ? true : false
        
        DispatchQueue.global().async { [ weak self ] in
            
            guard let self = self else { return }
            
            Alamofire.request(self.urlConstructor.allWeather(lat: lat, lon: lon)).validate()
                .responseJSON { response in
                
                    if let error = response.error {
                        print(error.localizedDescription)
                        
                        return
                    }
                    
                    guard let data = response.data else {
                        print("error: data is equal to nil")
                        
                        return
                    }
                    
                    guard let allData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any], let hourlyData = allData["hourly"] as? [[String : Any]],
                          let dailyData = allData["daily"] as? [[String : Any]] else { return }
                    
                    let informationWeather = InformationData(
                        lowlestGraduation: (((allData["daily"] as? [[String : Any]])?[0]["temp"] as? [String : Any])?["min"] as? Double) ?? 0,
                        bigestGraduation: (((allData["daily"] as? [[String : Any]])?[0]["temp"] as? [String : Any])?["max"] as? Double) ?? 0,
                        nowGraduation: ((allData["current"] as? [String : Any])?["temp"] as? Double) ?? 0,
                        text: (((allData["current"] as? [String : Any])?["weather"] as? [[String : Any]])?[0]["description"] as? String) ?? "none",
                        sunriseTime: self.unixTimeConvertion(unixTime: ((allData["daily"] as? [[String : Any]])?[0]["sunrise"] as? Double ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                        sunsetTime: self.unixTimeConvertion(unixTime: ((allData["daily"] as? [[String : Any]])?[0]["sunset"] as? Double ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                        number: ((allData["current"] as? [String : Any])?["clouds"] as? Int) ?? 0,
                        windSpeed: ((allData["current"] as? [String : Any])?["wind_speed"] as? Double) ?? 0,
                        humidityProcent: ((allData["current"] as? [String : Any])?["humidity"] as? Int) ?? 0,
                        informaton: self.unixTimeConvertion(unixTime: NSDate().timeIntervalSinceNow, dateFormat: isTwentyFourFormate ? .twentyFourWeekday : .twentyFourWeekday))
                                    
                    var hours = [OneHourWeather]()
                    
                    for hour in hourlyData {
                        
                        let oneHour = OneHourWeather(
                            time: self.unixTimeConvertion(unixTime: (hour["dt"] as? Double) ?? 0,
                                                         dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                            graduation: (hour["temp"] as? Double) ?? 0,
                            weather: ((hour["weather"] as? [[String : Any]])?[0]["icon"] as? String) != "04d" ? "Frame" : "Frame-3"
                        )
                        
                        hours.append(oneHour)
                                            
                    }
                                    
                    var days = [OneDayWeather]()
                    
                    for day in dailyData {
                        
                        let oneDay = OneDayWeather(
                            date: self.unixTimeConvertion(unixTime: (day["dt"] as? Double) ?? 0,
                                                          dateFormat: .weekday),
                            humidityProcent: (day["humidity"] as? Int) ?? 0,
                            graduationsDifference: "\(((day["temp"] as? [String : Any])?["min"] as? Double) ?? 0)° - \(((day["temp"] as? [String : Any])?["max"] as? Double) ?? 0)°",
                            information: ((day["weather"] as? [[String : Any]])?[0]["description"] as? String) ?? ""
                        )
                        
                        days.append(oneDay)
                                            
                    }
                                    
                    var oneHourWeather = [TwentyFourHoursWeather]()
                    
                    for oneHour in hourlyData {
                        
                        let weather = TwentyFourHoursWeather(
                            date: self.unixTimeConvertion(unixTime: (oneHour["dt"] as? Double) ?? 0, dateFormat: .weekday),
                            time: self.unixTimeConvertion(unixTime: (oneHour["dt"] as? Double) ?? 0, dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                            graduation: (oneHour["temp"] as? Double) ?? 0,
                            cloudy: ((oneHour["weather"] as? [[String : Any]])?[0]["description"] as? String) ?? "none",
                            windSpeed: (oneHour["wind_speed"] as? Double) ?? 0,
                            hummidityProcent: (oneHour["humidity"] as? Int) ?? 0,
                            cloudyProcent: (oneHour["clouds"] as? Int) ?? 0,
                            isNight: (self.unixHours(unixTime: (oneHour["dt"] as? Double) ?? 0) < 5) ? true : false
                        )
                        
                        oneHourWeather.append(weather)
                        
                    }
                                    
                    var twentyFiveDays = [(weather: [TwentyFiveDaysWeather],
                                  sunriseSunset: SunsetSinrise,
                                  time: String,
                                 airPoints: Int)]()
                    
                    for day in dailyData {
                        
                        let oneDay = (weather: [TwentyFiveDaysWeather(
                            isNight: false,
                            isRain: (((day["humidity"] as? Int) ?? 0) > 30) ? true : false,
                            graduation: ((day["temp"] as? [String : Any])?["day"] as? Double) ?? 0,
                            realGraduation: ((day["feels_like"] as? [String : Any])?["day"] as? Double) ?? 0,
                            windSpeed: (day["wind_speed"] as? Double) ?? 0,
                            index: (day["uvi"] as? Int) ?? 0,
                            rainyProcent: (day["humidity"] as? Int) ?? 0,
                            cloudyProcent: (day["clouds"] as? Int) ?? 0
                        ), TwentyFiveDaysWeather(
                            isNight: true,
                            isRain: (((day["humidity"] as? Int) ?? 0) > 30) ? true : false,
                            graduation: ((day["temp"] as? [String : Any])?["day"] as? Double) ?? 0,
                            realGraduation: ((day["feels_like"] as? [String : Any])?["night"] as? Double) ?? 0,
                            windSpeed: (day["wind_speed"] as? Double) ?? 0,
                            index: (day["uvi"] as? Int) ?? 0,
                            rainyProcent: (day["humidity"] as? Int) ?? 0,
                            cloudyProcent: (day["clouds"] as? Int) ?? 0
                        )], sunriseSunset: SunsetSinrise(
                            sunriseTime: self.unixTimeConvertion(unixTime: ((day["sunrise"] as? Double) ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                            sunsetTime: self.unixTimeConvertion(unixTime: ((day["sunset"] as? Double) ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                            sun: "\((24 - (self.unixHours(unixTime: (day["sunrise"] as? Double) ?? 0) - self.unixHours(unixTime: (day["sunrise"] as? Double) ?? 0)))):00",
                            moon: "\((24 - (self.unixHours(unixTime: (day["sunset"] as? Double) ?? 0) - self.unixHours(unixTime: (day["sunrise"] as? Double) ?? 0)))):00"
                        ), time: self.unixTimeConvertion(unixTime: ((day["dt"] as? Double) ?? 0),
                                                         dateFormat: .weekday
                        ), airPoints: (day["clouds"] as? Int) ?? 0)
                        
                        twentyFiveDays.append(oneDay)
                                            
                    }
                                    
                    let allDataWeather = (information: informationWeather,
                                          oneDayWeather: days,
                                          oneHourWeather: hours,
                                          twentyFourHoursWeather: oneHourWeather,
                                          twentyFiveDaysWeather: twentyFiveDays,
                                          cityName: name)
                    
                    self.allWeather.append(allDataWeather)
                    
                    let allStringWeather = Weather()
                    
                    allStringWeather.allWeather = data
                    allStringWeather.name = name
                    
                    do {
                        guard let realm = self.realm else { return }
                        
                        realm.beginWrite()
                        realm.add(allStringWeather)
                        try realm.commitWrite()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }.resume()
            
        }
        
    }
    
    func getAllCache(data: Data, name: String) {
                
        let isTwentyFourFormate = self.userDefaults.integer(forKey: "time") == 24 ? true : false
        
        guard let allData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any], let hourlyData = allData["hourly"] as? [[String : Any]], let dailyData = allData["daily"] as? [[String : Any]] else { return }
        
        if allData.count == 0 || name == "" { return }
        
        let informationWeather = InformationData(
            lowlestGraduation: (((allData["daily"] as? [[String : Any]])?[0]["temp"] as? [String : Any])?["min"] as? Double) ?? 0,
            bigestGraduation: (((allData["daily"] as? [[String : Any]])?[0]["temp"] as? [String : Any])?["max"] as? Double) ?? 0,
            nowGraduation: ((allData["current"] as? [String : Any])?["temp"] as? Double) ?? 0,
            text: (((allData["current"] as? [String : Any])?["weather"] as? [[String : Any]])?[0]["description"] as? String) ?? "none",
            sunriseTime: self.unixTimeConvertion(unixTime: ((allData["daily"] as? [[String : Any]])?[0]["sunrise"] as? Double ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
            sunsetTime: self.unixTimeConvertion(unixTime: ((allData["daily"] as? [[String : Any]])?[0]["sunset"] as? Double ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
            number: ((allData["current"] as? [String : Any])?["clouds"] as? Int) ?? 0,
            windSpeed: ((allData["current"] as? [String : Any])?["wind_speed"] as? Double) ?? 0,
            humidityProcent: ((allData["current"] as? [String : Any])?["humidity"] as? Int) ?? 0,
            informaton: self.unixTimeConvertion(unixTime: NSDate().timeIntervalSinceNow, dateFormat: isTwentyFourFormate ? .twentyFourWeekday : .twentyFourWeekday))
                        
        var hours = [OneHourWeather]()
        
        for hour in hourlyData {
            
            let oneHour = OneHourWeather(
                time: self.unixTimeConvertion(unixTime: (hour["dt"] as? Double) ?? 0,
                                             dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                graduation: (hour["temp"] as? Double) ?? 0,
                weather: ((hour["weather"] as? [[String : Any]])?[0]["icon"] as? String) != "04d" ? "Frame" : "Frame-3"
            )
            
            hours.append(oneHour)
                                
        }
                        
        var days = [OneDayWeather]()
        
        for day in dailyData {
            
            let oneDay = OneDayWeather(
                date: self.unixTimeConvertion(unixTime: (day["dt"] as? Double) ?? 0,
                                              dateFormat: .weekday),
                humidityProcent: (day["humidity"] as? Int) ?? 0,
                graduationsDifference: "\(((day["temp"] as? [String : Any])?["min"] as? Double) ?? 0)° - \(((day["temp"] as? [String : Any])?["max"] as? Double) ?? 0)°",
                information: ((day["weather"] as? [[String : Any]])?[0]["description"] as? String) ?? ""
            )
            
            days.append(oneDay)
                                
        }
                        
        var oneHourWeather = [TwentyFourHoursWeather]()
        
        for oneHour in hourlyData {
            
            let weather = TwentyFourHoursWeather(
                date: self.unixTimeConvertion(unixTime: (oneHour["dt"] as? Double) ?? 0, dateFormat: .weekday),
                time: self.unixTimeConvertion(unixTime: (oneHour["dt"] as? Double) ?? 0, dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                graduation: (oneHour["temp"] as? Double) ?? 0,
                cloudy: ((oneHour["weather"] as? [[String : Any]])?[0]["description"] as? String) ?? "none",
                windSpeed: (oneHour["wind_speed"] as? Double) ?? 0,
                hummidityProcent: (oneHour["humidity"] as? Int) ?? 0,
                cloudyProcent: (oneHour["clouds"] as? Int) ?? 0,
                isNight: (self.unixHours(unixTime: (oneHour["dt"] as? Double) ?? 0) < 5) ? true : false
            )
            
            oneHourWeather.append(weather)
            
        }
                        
        var twentyFiveDays = [(weather: [TwentyFiveDaysWeather],
                      sunriseSunset: SunsetSinrise,
                      time: String,
                     airPoints: Int)]()
        
        for day in dailyData {
            
            let oneDay = (weather: [TwentyFiveDaysWeather(
                isNight: false,
                isRain: (((day["humidity"] as? Int) ?? 0) > 30) ? true : false,
                graduation: ((day["temp"] as? [String : Any])?["day"] as? Double) ?? 0,
                realGraduation: ((day["feels_like"] as? [String : Any])?["day"] as? Double) ?? 0,
                windSpeed: (day["wind_speed"] as? Double) ?? 0,
                index: (day["uvi"] as? Int) ?? 0,
                rainyProcent: (day["humidity"] as? Int) ?? 0,
                cloudyProcent: (day["clouds"] as? Int) ?? 0
            ), TwentyFiveDaysWeather(
                isNight: true,
                isRain: (((day["humidity"] as? Int) ?? 0) > 30) ? true : false,
                graduation: ((day["temp"] as? [String : Any])?["day"] as? Double) ?? 0,
                realGraduation: ((day["feels_like"] as? [String : Any])?["night"] as? Double) ?? 0,
                windSpeed: (day["wind_speed"] as? Double) ?? 0,
                index: (day["uvi"] as? Int) ?? 0,
                rainyProcent: (day["humidity"] as? Int) ?? 0,
                cloudyProcent: (day["clouds"] as? Int) ?? 0
            )], sunriseSunset: SunsetSinrise(
                sunriseTime: self.unixTimeConvertion(unixTime: ((day["sunrise"] as? Double) ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                sunsetTime: self.unixTimeConvertion(unixTime: ((day["sunset"] as? Double) ?? 0), dateFormat: isTwentyFourFormate ? .twentyFourTime : .twelveTime),
                sun: "\((24 - (self.unixHours(unixTime: (day["sunrise"] as? Double) ?? 0) - self.unixHours(unixTime: (day["sunrise"] as? Double) ?? 0)))):00",
                moon: "\((24 - (self.unixHours(unixTime: (day["sunset"] as? Double) ?? 0) - self.unixHours(unixTime: (day["sunrise"] as? Double) ?? 0)))):00"
            ), time: self.unixTimeConvertion(unixTime: ((day["dt"] as? Double) ?? 0),
                                             dateFormat: .weekday
            ), airPoints: (day["clouds"] as? Int) ?? 0)
            
            twentyFiveDays.append(oneDay)
                                
        }
                        
        let allDataWeather = (information: informationWeather,
                              oneDayWeather: days,
                              oneHourWeather: hours,
                              twentyFourHoursWeather: oneHourWeather,
                              twentyFiveDaysWeather: twentyFiveDays,
                              cityName: name)
        
        self.allWeather.append(allDataWeather)
        
    }
    
    func addLocationCity(lat: Float, lon: Float) {
        
        guard var citys = userDefaults.object(forKey: "citys") as? [String]? else { return }
        
        DispatchQueue.global().sync { [ weak self ] in
            
            guard let self = self else { return }
            
            Alamofire.request(self.urlConstructor.addLocationURL(lat: lat, lon: lon)).validate()
                .responseJSON { response in
                    
                    if let error = response.error {
                        print(error.localizedDescription)
                        
                        return
                    }
                    
                    guard let data = response.data else {
                        print("error: data is equal to nil")
                        
                        return
                    }
                    
                    guard let stringData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any], let cityName = stringData["name"] as? String else { return }
                    
                    if citys == nil {
                        citys = []
                    }
                    
                    citys?.append(cityName)
                    
                    self.userDefaults.set(citys, forKey: "citys")
                                    
                    self.homepageWeatherRequest()
                    
                }.resume()
            
        }
        
    }
    
}

extension DataManager {
    
    private func unixTimeConvertion(unixTime: Double, dateFormat: TimeFormat) -> String {
                
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormat.rawValue
        
        let strDate = dateFormatter.string(from: date)
        
        return strDate
        
    }
    
    private func unixHours(unixTime: Double) -> Int {
                
        let time = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()

        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
        dateFormatter.dateFormat = "hh:mm a"
                
        let dateAsString = dateFormatter.string(from: time as Date)
        
        dateFormatter.dateFormat = "h:mm a"
        
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "HH"
        
        let hours = Int(dateFormatter.string(from: date ?? Date()))
        
        return hours ?? 0
        
    }
    
}

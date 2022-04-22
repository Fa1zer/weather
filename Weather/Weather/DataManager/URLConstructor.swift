//
//  DataManager.swift
//  Weather
//
//  Created by Artemiy Zuzin on 27.02.2022.
//

import Foundation

final class URLConstructor {
    
    init(apiKey: String) {
        
        self.apiKey = apiKey
        
    }
    
    private init() {
        
        self.apiKey = "bb0dacf60196ccb787e208c22bdb5076"
        
    }
    
    private let apiKey: String
    
    static let standart = URLConstructor()
    
    private let userDefults = UserDefaults()
    
    func addLocationURL(lat: Float, lon: Float) -> URL {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?&appid=\(self.apiKey)&lat=\(lat)&lon=\(lon)&lang=ru"
                
        guard let unwarpURL = URL(string: url) else { return URL(fileURLWithPath: "") }
        
        return unwarpURL
        
    }
    
    func geocoderURL(geocode: String) -> URL {
        
        var url = "https://api.openweathermap.org/data/2.5/weather?&lang=ru&appid=\(self.apiKey)"
        
        if geocode != "" {
            
            url = url + "&q=\(geocode)"
            
        }
        
        guard let encodeString = url.encodeUrl,
              let unwarpURL = URL(string: encodeString) else { return URL(fileURLWithPath: "") }
        
        return unwarpURL
        
    }
    
    func allWeather(lat: Float, lon: Float) -> URL {
        
        var url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=\(self.apiKey)&lang=ru&exclude=alerts"
        
        if userDefults.string(forKey: "speed") == "Km" || userDefults.string(forKey: "temperature") == "C" {
            url += "&units=metric"
            
            self.userDefults.set("Km", forKey: "speed")
            self.userDefults.set("C", forKey: "temperature")
        } else {
            url += "&units=imperial"
            
            self.userDefults.set("Mi", forKey: "speed")
            self.userDefults.set("F", forKey: "temperature")
        }
        
        guard let unwarpURL = URL(string: url) else { return URL(fileURLWithPath: "") }
        
        return unwarpURL
        
    }
    
}

extension String {
    
    var encodeUrl : String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var decodeUrl : String? {
        return self.removingPercentEncoding
    }
    
}

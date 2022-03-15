//
//  SettingsModule.swift
//  Weather
//
//  Created by Artemiy Zuzin on 21.02.2022.
//

import Foundation

final class SettingsModel {
    
    var dataManager: DataManager?
    
    func setupSettings() {
        
        self.dataManager?.homepageWeatherRequest()
        
    }
    
}

//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 21.02.2022.
//

import Foundation

final class SettingsViewModel: Coordinatable {
    
    init(dataManager: DataManager) {
        
        self.model.dataManager = dataManager
        
    }
    
    var appCoordinator: AppCoordinator?
    
    private let model = SettingsModel()
    private let userDefaults = UserDefaults.standard
    
    func selectSettingsNow() -> (temperature: String, speed: String, time: Int, notifications: Bool) {
        return (temperature: self.userDefaults.string(forKey: "temperature") ?? "",
                speed: self.userDefaults.string(forKey: "speed") ?? "",
                time: self.userDefaults.integer(forKey: "time"),
                notifications: self.userDefaults.bool(forKey: "notifications"))
    }
    
    func save() {
        
        DispatchQueue.main.async { [ weak self ] in
            
            self?.model.setupSettings()
            self?.appCoordinator?.goToHomepage()
            
        }
        
    }
    
    func didChangeFirst(number: Int) {
        
        switch number{
        case 0:
            self.userDefaults.set("C", forKey: "temperature")
            self.userDefaults.set("Km", forKey: "speed")
        case 1:
            self.userDefaults.set("F", forKey: "temperature")
            self.userDefaults.set("Mi", forKey: "speed")
        default:
            return
        }
        
    }
    
    func didChangeSecond(number: Int) {
        
        switch number {
        case 0:
            self.userDefaults.set("Mi", forKey: "speed")
            self.userDefaults.set("F", forKey: "temperature")
        case 1:
            self.userDefaults.set("Km", forKey: "speed")
            self.userDefaults.set("C", forKey: "temperature")
        default:
            return
        }
        
    }
    
    func didChangeThird(number: Int) {
        
        switch number {
        case 0:
            userDefaults.set(12, forKey: "time")
        case 1:
            userDefaults.set(24, forKey: "time")
        default:
            return
        }
        
    }
    
    func didChangeFourth(number: Int) {
        switch number {
        case 0:
            userDefaults.set(true, forKey: "notifications")
        case 1:
            userDefaults.set(false, forKey: "notifications")
        default:
            return
        }
        
    }
    
}

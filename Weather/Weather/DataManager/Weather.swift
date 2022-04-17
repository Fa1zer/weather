//
//  Weather.swift
//  Weather
//
//  Created by Artemiy Zuzin on 14.03.2022.
//

import Foundation
import RealmSwift

class Weather: Object {
    
    @objc dynamic var allWeather = Data()
    @objc dynamic var name = String()
    
}

//
//  WeatherModel.swift
//  Clima
//
//  Created by Rishav Gupta on 07/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // computed property
    // 1. computed property are always var becoz value is always gonna change
    // 2. It returns a value
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch(conditionId) {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...771:
            return "sun.dust"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "smoke"
        default:
            return "cloud"
        }
    }
    
//    func getConditionName(weatherId: Int) -> String {
//        switch(weatherId) {
//        case 200...232:
//            return "cloud.bolt.rain"
//        case 300...321:
//            return "cloud.drizzle"
//        case 500...531:
//            return "cloud.rain"
//        case 600...622:
//            return "snow"
//        case 701...771:
//            return "sun.dust"
//        case 781:
//            return "tornado"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "smoke"
//        default:
//            return "cloud"
//        }
//    }
}

//
//  WeatherDataItem.swift
//  RemoteDataDemo
//
//  Created by Chang, Emily on 8/3/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import Foundation

struct WeatherDataItem {
    var dayOfWeek: String
    var highTemp: Int
    var lowTemp: Int
    var currentTemp: Int
    var description: String
    
    init?(json: [String: Any]) {
        guard let dt = json["dt"] as? Double,
            let temp = json["temp"] as? [String: Any],
            let min = temp["min"] as? Double,
            let max = temp["max"] as? Double,
            let day = temp["day"] as? Double,
            let weather = json["weather"] as? [[String: Any]],
            let firstWeather = weather.first,
            let main = firstWeather["main"] as? String
            else {
                return nil
        }
        
        self.highTemp = Int(max)
        self.lowTemp = Int(min)
        self.currentTemp = Int(day)
        self.description = main
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        let date = Date(timeIntervalSince1970: dt)
        self.dayOfWeek = formatter.string(from: date)
    }
}

//
//  WeatherDataService.swift
//  RemoteDataDemo
//
//  Created by Chang, Emily on 8/3/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import Foundation

class WeatherDataService {
    static let sharedInstance = WeatherDataService()
    private let urlSession = URLSession(configuration: .default)
    private let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=LosAngeles&mode=json&units=imperial&cnt=7&appid=bd43377aeae4f4b3f5e2d60b64075902"
    
    private init() { }
    
    func getWeatherData(completion: @escaping (_ weatherData: [WeatherDataItem]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = jsonObject as? [String: Any],
                let weatherDataResponse = WeatherDataResponse(json: json),
                error == nil else {
                    completion(nil)
                    return
            }
            completion(weatherDataResponse.weatherData)
        })
        
        dataTask.resume()
    }
}

fileprivate struct WeatherDataResponse {
    var weatherData: [WeatherDataItem]?
    
    init?(json: [String: Any]) {
        guard let list = json["list"] as? [[String: Any]] else {
            return nil
        }
        
        weatherData = [WeatherDataItem]()
        
        for item in list {
            if let weatherDataItem = WeatherDataItem(json: item) {
                weatherData!.append(weatherDataItem)
            }
        }
        
    }
}

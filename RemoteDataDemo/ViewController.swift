//
//  ViewController.swift
//  RemoteDataDemo
//
//  Created by Chang, Emily on 6/26/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let cellIdentifier = "ForecastCell"
    var weatherData = [WeatherDataItem]()
    private lazy var weatherDataService = WeatherDataService.sharedInstance
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadWeatherData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loadWeatherData() {
        if let city = loadCity() {
            self.city = city
        }
        else {
            city = "LosAngeles"
        }
        
        weatherDataService.urlString = generateURLString()
        print("fetching data from \(weatherDataService.urlString)")

        weatherDataService.getWeatherData { [weak self] (weatherDataItems) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            guard let weatherDataItems = weatherDataItems else { return }
            DispatchQueue.main.async {
                self?.weatherData = weatherDataItems
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func generateURLString() -> String {
        let cityNoSpaces = city.removingWhitespaces()
        return "https://api.openweathermap.org/data/2.5/forecast/daily?q=" + cityNoSpaces + "&mode=json&units=imperial&cnt=7&appid=bd43377aeae4f4b3f5e2d60b64075902"
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ForecastCollectionViewCell
        
        let weatherDataItem = weatherData[indexPath.item]
        
        cell.dayOfTheWeekLabel.text = weatherDataItem.dayOfWeek
        cell.highLabel.text = "\(weatherDataItem.highTemp)"
        cell.lowLabel.text = "\(weatherDataItem.lowTemp)"
        cell.nowLabel.text = "\(weatherDataItem.dayTemp)"
        cell.descriptionLabel.text = weatherDataItem.description
        
        return cell
    }
    private func saveCity() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(city, toFile: Settings.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("City successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCity() -> String? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? String
    }
    
    @IBAction func unwindToWeather(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SettingsViewController,
            let city = sourceViewController.cityLabel.text {
            self.city = city
            saveCity()
        }
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}


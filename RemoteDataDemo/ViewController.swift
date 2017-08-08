//
//  ViewController.swift
//  RemoteDataDemo
//
//  Created by Chang, Emily on 6/26/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "ForecastCell"
    var weatherData = [WeatherDataItem]()
    private lazy var weatherDataService = WeatherDataService.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadWeatherData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loadWeatherData() {
        weatherDataService.getWeatherData { [weak self] (weatherDataItems) in
            guard let weatherDataItems = weatherDataItems else { return }
            DispatchQueue.main.async {
                self?.weatherData = weatherDataItems
                self?.collectionView.reloadData()
            }
            
            
        }
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
        cell.nowLabel.text = "\(weatherDataItem.currentTemp)"
        cell.descriptionLabel.text = weatherDataItem.description
        
        return cell
    }

}


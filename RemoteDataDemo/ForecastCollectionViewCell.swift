//
//  ForecastCollectionViewCell.swift
//  RemoteDataDemo
//
//  Created by Chang, Emily on 8/3/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.red.cgColor
    }
}

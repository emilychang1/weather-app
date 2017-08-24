//
//  SettingsViewController.swift
//  RemoteDataDemo
//
//  Created by Emily Chang on 8/23/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit
import os.log

class SettingsViewController: UIViewController {
    @IBOutlet weak var cityLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCity()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    private func loadCity()  {
        let savedCity = NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? String
        cityLabel.text = savedCity
    }

}

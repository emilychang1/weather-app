//
//  Settings.swift
//  RemoteDataDemo
//
//  Created by Emily Chang on 8/23/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import Foundation
import os.log

class Settings: NSObject, NSCoding {
    
    //MARK: Properties
    
    var city: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("city")
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let city = "city"
    }
    
    
    //MARK: Initialization
    
    init?(city: String) {
        // The name must not be empty
        guard !city.isEmpty else {
            return nil
        }
        self.city = city
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(city, forKey: PropertyKey.city)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {

        guard let city = aDecoder.decodeObject(forKey: PropertyKey.city) as? String else {
            os_log("Unable to decode the name for a city.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(city: city)
    }
}

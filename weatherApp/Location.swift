//
//  Location.swift
//  weatherApp
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/5/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import CoreLocation
class Location {
    static var sharedInstance = Location()
    private init(){ }
    var latitude: Double!
    var longitude: Double!
}

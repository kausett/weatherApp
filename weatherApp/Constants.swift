//
//  Constants.swift
//  weatherApp
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/4/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//



// Inorder to use this have an API 
// Learn how ro create an API

import Foundation
    let LONGITUDE_POINT = Location.sharedInstance.longitude!
    let LATITUDE_POINT = Location.sharedInstance.latitude!
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
    let LATITUDE = "lat="
    let LONGITUDE = "&lon="
    let APP_ID="&appid="
    let API_KEY = "5b8f29727a27e187f3d4fa03ecd6c8d2"
    let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LATITUDE_POINT)\(LONGITUDE)\(LONGITUDE_POINT)\(APP_ID)\(API_KEY)"
    //This let you know that the process is compoleted
    typealias DownloadComplete = () -> ()
    



    let F_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
    let F_LATITUDE = "lat="
    let F_LONGITUDE = "&lon="
    let F_APP_ID="&appid="
    let F_COUNT = "&\(10)"
    let F_WEATHER_URL = "\(F_BASE_URL)\(F_LATITUDE)\(LATITUDE_POINT)\(F_LONGITUDE)\(LONGITUDE_POINT)\(F_COUNT)\(F_APP_ID)\(API_KEY)"

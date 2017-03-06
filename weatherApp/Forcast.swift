//
//  Forcast.swift
//  weatherApp
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/5/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit
import Alamofire

class Forcast{

    var currentWeatherClass = CurrentWeather()
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp:String!
    
    
    
    
    var date:String{
        if _date == nil{
            _date = ""
        }
        return _date
        
    }
    
    
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
            
        }
        return _weatherType
    }

    
    var highTemp: String{
        if _highTemp == nil {
            _highTemp = "\(0.0)"
        }
        return _highTemp
    }
    
    
    var lowTemp: String{
        if _lowTemp == nil {
            _lowTemp = "\(0.0)"
        }
        return _lowTemp
    }
    
   
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
           
            if let min = temp["min"] as? Double{
                var kelvin2Fern = currentWeatherClass.kelvin2Ferenheight(kelv: min)
                kelvin2Fern = round(10 * kelvin2Fern / 10)
                self._lowTemp = "\(kelvin2Fern)"
            }
            
            
            if let max = temp["max"] as? Double{
                var kelvin2Fern = currentWeatherClass.kelvin2Ferenheight(kelv: max)
                kelvin2Fern = round(10 * kelvin2Fern / 10)
                self._highTemp = "\(kelvin2Fern)"
            }
            
            
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixCOnvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixCOnvertedDate.dayOfTheWeek()
            
            
        }
        
    }
    
    
}



extension Date{
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

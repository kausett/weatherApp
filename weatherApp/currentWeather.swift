//
//  currentWeather.swift
//  weatherApp
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/4/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
        var _cityName: String!
        var _date: String!
        var _weatherType: String!
        var _currentTemp: Double!
        
        
        
        var  cityName:String{
            if _cityName == nil {
                _cityName = ""
            }
            return _cityName
        }
        
        
        var  weatherType:String{
            if _weatherType == nil {
                _weatherType = ""
            }
            
            return _weatherType
        }
        
        var  currentTemp:Double{
            if _currentTemp == nil {
                _currentTemp = 0.0
            }
            return _currentTemp
        }


        // When using a date always use the datestyle and the timestyle
        var date:String {

            if _date == nil {
                _date = ""
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let currentDate  = dateFormatter.string(from: Date())
            
            self._date = "Today, \(currentDate)"
            return _date
        }
        
        
        func kelvin2Ferenheight(kelv: Double) -> Double {
            
            let Ferenheight: Double = (kelv * (9/5) - 459.67)
            return Ferenheight
        }
    
    
        
        func downloadWeatherDetails(completed:  @escaping DownloadComplete)  {
            //Alamofire downloadfrom 
            
            
            let currentUrl  = URL(string: CURRENT_WEATHER_URL)!
            Alamofire.request(currentUrl).responseJSON { response in
                let result = response.result
                
                if let dict = result.value as? Dictionary<String,AnyObject>{ //access the Json Object first dict
                    
                    
                    if let name = dict["name"] as? String{
                        self._cityName = name.capitalized
                        
                        print("the city name is "+self._cityName)
                    }
                    
                    
                    if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                        if let main = weather[0]["main"] as? String{
                            self._weatherType = main.capitalized
                        }
                        
                        //print(self.weatherType)
                    }
                    
                    
                    if let main = dict["main"] as? Dictionary<String, AnyObject>{
                        
                        if let currentTemperature = main["temp"] as? Double{
                            
                            var kevin2Feren: Double = self.kelvin2Ferenheight(kelv: currentTemperature)
                            
                            kevin2Feren = round(10 * kevin2Feren / 10)
                            
                            self._currentTemp = kevin2Feren
                        }
                       // print(self.date)
                       // print(self.currentTemp)
                    }
                    
                    
                }
                 completed()
            }
            
           
        }
        
}

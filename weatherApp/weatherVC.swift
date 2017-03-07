//
//  weatherVC.swift
//  weatherApp
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/4/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class weatherVC: UIViewController , UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    let LocationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var forcasts = [Forcast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        LocationAuthStatus()
        
    }
    

    
    func LocationAuthStatus(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways, .authorizedWhenInUse:
            LocationManager.delegate = self
            LocationAuthorized()
            print("Authorized !!")
        case .notDetermined:
            LocationManager.delegate = self
            LocationManager.requestWhenInUseAuthorization()
            print("Asking For Permission")
        case .denied:
            print("Showig alert with Link to Settings")
        case .restricted:
            //Theres nothi one can do. App cannot use location services
            
            break
        }
    }
    
    
    //Getting the precized location if authorized
    func LocationAuthorized(){
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest //use the best prised location
        LocationManager.startMonitoringSignificantLocationChanges()
        LocationManager.startUpdatingLocation()
        currentLocation = LocationManager.location
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        
        print(Location.sharedInstance.latitude ,Location.sharedInstance.longitude,CURRENT_WEATHER_URL)
        currentWeather.downloadWeatherDetails {
            self.downloadFocastWeatherdata {
                self.updateMainui()
                
                
            }
        }
    }
    
    //Check if authoirized to use location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status  == .authorizedWhenInUse || status == .authorizedAlways{
            print("Checking!!")
            LocationAuthorized()
        }else if status == .denied{
            print("What Why")
        }
    }

    
    
    func downloadFocastWeatherdata(compledted: @escaping DownloadComplete){
        let forcastURL = URL(string: F_WEATHER_URL)!
        Alamofire.request(forcastURL).responseJSON { response in
            let result = response.result
            print(response)
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for object in list{
                        let forCast = Forcast(weatherDict: object)
                        self.forcasts.append(forCast)
                        print(object)
                    }
                    //self.forcasts.remove(at: 0)
                    for obj in self.forcasts{
                        print("Hey im here",obj.date)
                    }
                    
                    self.tableView.reloadData()
                }
            }
            
            compledted()
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return   1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? weatherCell{
            let forecast =  forcasts[indexPath.row]
            cell.configCell(forcast: forecast)
            return cell
        }else{
            return weatherCell()
        }
    }
    
    
    func updateMainui(){
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = ("\(currentWeather.currentTemp)º F")
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
       
    }
}


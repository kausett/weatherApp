//
//  weatherCell.swift
//  weatherApp
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/5/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
 
    
    func configCell(forcast: Forcast){
        lowTemp.text = "Low:\(forcast.lowTemp)º F"
        highTemp.text = "High:\(forcast.highTemp)º F"
        dayLabel.text = forcast.date
        weatherIcon.image = UIImage(named: forcast.weatherType)
        weatherType.text   = forcast.weatherType
        
    }
    
}

//
//  DriverClass.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 25/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

class Driver {
 
    var latitude: Double = 0
    var longitude: Double = 0
    var speedlimit: Double = 0
    
    func updateLocation(lat: Double, long: Double){
        self.latitude = lat
        self.longitude = long
    }
    func updateSpeedlimit(speed: Double){
        self.speedlimit = speed
    }
}



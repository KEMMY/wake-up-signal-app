//
//  Driver2.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 4/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

class DriverHealthProfile {
    var dateOfBirth: Date?
    var age,stepcount,distanceWalked: Int?
    var bloodType: String?
    var weight,height,activeEnergy,bodyMass,heartRate: Double?
    var biologicalSex: String?
    //for apple watch wearers
    var bloodGlucose,bodyTemperature,oxygenSaturation,numberOfTimesFallen: Double?
    
    init(dateOfBirth: Date? = nil,age: Int? = nil,stepcount: Int? = nil,distanceWalked: Int? = nil, bloodType: String? = nil,  weight: Double? = nil,  height: Double? = nil,activeEnergy: Double? = nil,bodyMass: Double? = nil,heartRate: Double? = nil, biologicalSex: String? = nil,bloodGlucose: Double? = nil,bodyTemperature: Double? = nil,oxygenSaturation: Double? = nil,numberOfTimesFallen: Double? = nil ) {
       
        // Num. Represent the UIImageCode
        
        self.dateOfBirth = dateOfBirth //0
        self.age = age //1
        self.stepcount = stepcount //2
        self.distanceWalked = distanceWalked //3
        self.bloodType = bloodType //4
        self.weight = weight //5
        self.height = height //6
        self.activeEnergy = activeEnergy //7
        self.bodyMass = bodyMass //8
        self.heartRate = heartRate //9
        self.biologicalSex = biologicalSex //10
        self.bloodGlucose = bloodGlucose //11
        self.bodyTemperature = bodyTemperature //12
        self.oxygenSaturation = oxygenSaturation //13
        self.numberOfTimesFallen = numberOfTimesFallen //14
    }
    func updateHeight(h:Double){
        self.height = h
    }
    
}


//
//  WakeUpManager.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 21/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation


public class WakeUpManager{
    
    static let shared = WakeUpManager()
    
    //global HealthProfile
    var DHR = DriverHealthProfile(dateOfBirth: Date().startOfDay, age: 0, stepcount: 0, distanceWalked: 0, bloodType: "0", weight: 0.0, height: 0.0, activeEnergy: 0.0, bodyMass: 0.0, heartRate: 0.0, biologicalSex: "No Gender", bloodGlucose: 0.0, bodyTemperature: 0.0, oxygenSaturation: 0.0, numberOfTimesFallen: 0.0)
    var JL:[JourneyRecord] = []
    var uID:String = ""
    var newJourneyID:String = ""
    var wasNewJourneyTrigered: Bool = false
    var fatique:Double = 0.0
    var emergency:Bool = false
    var emergencyMessage: String = ""
    
    init(){}
    
    
    // Requests
    
    func requestForHealthProfile() -> DriverHealthProfile {
//        let hp = DriverHealthProfile(dateOfBirth: Date(), age: 28, stepcount: 123, distanceWalked: 123, bloodType: "A+", weight: 123, height: 123, activeEnergy: 123, bodyMass: 123.0, heartRate: 123.0, biologicalSex: "Male", bloodGlucose: 123, bodyTemperature: 123, oxygenSaturation: 123, numberOfTimesFallen: 123)
        return DHR
    }
    
    func requestFatique() -> Double {
        return fatique
    }
    
    func requestJourneyList() -> [JourneyRecord] {
        return JL
    }
    func requestUID() -> String {
        return uID
    }
    
    func requestDHRHash() -> String {
        let data:String = String(DHR.activeEnergy!) + String(DHR.age!) + DHR.biologicalSex! + DHR.bloodType! + String(DHR.distanceWalked!) + String(DHR.weight!) + String(DHR.height!) + String(DHR.stepcount!)
        let md5Data = MD5(string:data)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    
    //Setup
    
    func updateUID(newUID: String) {
        uID = newUID
    }
    
    
    func updateDHR(newDHR: DriverHealthProfile){
        DHR.activeEnergy = newDHR.activeEnergy
        DHR.age = newDHR.age
        DHR.biologicalSex = newDHR.biologicalSex
        DHR.bloodGlucose = newDHR.bloodGlucose
        DHR.bloodType = newDHR.bloodType
        DHR.bodyMass = newDHR.bodyMass
        DHR.bodyTemperature = newDHR.bodyTemperature
        //DHR.dateOfBirth
        DHR.distanceWalked = newDHR.distanceWalked
        DHR.heartRate = newDHR.heartRate
        DHR.height = newDHR.height
        DHR.numberOfTimesFallen = newDHR.numberOfTimesFallen
        DHR.oxygenSaturation = newDHR.oxygenSaturation
        DHR.stepcount = newDHR.stepcount
        DHR.weight = newDHR.weight
        // latter it can be updated by other parameters. 
    }
    
    func setFatique(newValue: Double){
        fatique = newValue
    }
    
    func setEmergency(newValue: Bool){
        emergency = newValue
    }
    
    func setEmergencyMessage(newValue: String){
        emergencyMessage = newValue
    }
    
    
    
    func newJourneyON() {
        wasNewJourneyTrigered = true
    }
    func newJourneyOFF() {
        wasNewJourneyTrigered = false
    }
    
    //Prints
    func printDHR() {
        print(DHR.age)
        print(DHR.height)
        print(DHR.biologicalSex)
        print(DHR.bloodType)
        print(DHR.weight)
        print(DHR.activeEnergy)
        print(DHR.bodyMass)
        print(DHR.bodyTemperature)
        print(DHR.distanceWalked)
        print(DHR.heartRate)
        print(DHR.numberOfTimesFallen)
        print(DHR.stepcount)
    }
    
}

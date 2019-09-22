//
//  HealthManager.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 18/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class HealtKitManager {
    
    var heigth: Double = 0.0
    
    let driver = DriverHealthProfile()
    //all health data storage
    //user is the master of their data
    let healthStore = HKHealthStore()
    
    func isHealthKitAuthorized() -> Bool{
        var isEnabled = true
        if HKHealthStore.isHealthDataAvailable() {
            let stepcount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) ?? 6)
            
            let dataTypesToRead = NSSet(object: stepcount)
            let dataTypesToWrite = NSSet(object: stepcount)
            
            healthStore.requestAuthorization(toShare: nil, read: (stepcount as! Set<HKObjectType>)) { (success, error) in
                isEnabled = success
            }
        }else {
                isEnabled = false
            }
            return isEnabled
        }
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HKError.errorHealthDataUnavailable as! Error)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let stepcount = HKObjectType.quantityType(forIdentifier: .stepCount),
            let distanceWalking = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let heartrate = HKObjectType.quantityType(forIdentifier: .heartRate),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
        //Only for Apple watch wearers
            let bloodGlucose = HKObjectType.quantityType(forIdentifier: .bloodGlucose),
            let bodyTemperature = HKObjectType.quantityType(forIdentifier: .bodyTemperature),
            let exygenSaturation = HKObjectType.quantityType(forIdentifier: .oxygenSaturation),
            let numebersOfTimeFallen = HKObjectType.quantityType(forIdentifier: .numberOfTimesFallen)
          
            
            else {
                completion(false, HKError.errorHealthDataUnavailable as! Error)
                return
        }
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       stepcount,
                                                       distanceWalking,
                                                       distanceWalking,
                                                       activeEnergy,
                                                       heartrate,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       bloodGlucose,
                                                       bodyTemperature,
                                                       exygenSaturation,
                                                       numebersOfTimeFallen]
        //4.Request Authorisation
        HKHealthStore().requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
      }


func getAgeSexAndBloodType() throws -> (age: Int,
    biologicalSex: HKBiologicalSex,
    bloodType: HKBloodType) {
        
        let healthKitStore = HKHealthStore()
        
        do {
            
            //1. This method throws an error if these data are not available.
            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
            let biologicalSex =       try healthKitStore.biologicalSex()
            let bloodType =           try healthKitStore.bloodType()
            //2. Use Calendar to calculate age.
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                              from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
            
            //3. Unwrap the wrappers to get the underlying enum values.
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
      }


     func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        //1. Use HKQuery to load the most recent samples.
        let today = Date()
        let startOfTheDay = Date().startOfDay
       // let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: startOfTheDay,
                                                              end: Date(),
                                                              options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        let limit = 1
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                            //2. Always dispatch to the main thread when complete.
                                            DispatchQueue.main.async {
                                                guard let samples = samples,
                                                    let mostRecentSample = samples.first as? HKQuantitySample else {
                                                        completion(nil, error)
                                                        return
                                                }
                                                
                                                completion(mostRecentSample, nil)
                                            }
        }
        HKHealthStore().execute(sampleQuery)
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>QueryExecuted>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    }

    func setHeitgh(h:Double){
        self.heigth = h
    }
    }





//
//  UserHealthController.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 16/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import UIKit
import Foundation
import HealthKit
import Firebase

class HealthController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
     var delegate:DataDelegate?
  
    let refreshHeathdataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh Heath Data", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(updateHealthView), for: .touchUpInside)
        return button
    }()
    
    let Hkit = HealtKitManager()
    let driverHealthProfile = DriverHealthProfile(dateOfBirth: NSDate() as Date, age: 0, stepcount: 0, distanceWalked: 0, bloodType: "No Type", weight: 0, height: 0, activeEnergy: 0, bodyMass: 0, heartRate: 0, biologicalSex: "No Gender", bloodGlucose: 0, bodyTemperature: 0, oxygenSaturation: 0, numberOfTimesFallen: 0)
    var items = [HealthRecord]()
    
    
    let TitleTextField: UITextField = {
        let txtField = UITextField()
        txtField.text = "Collected Health Data"
        return txtField
    }()
    
    
    
    
    let cellId = "HCellID"
    
    //Heath data
    //from items create current DriverHealthHeath
    var DriverHRecord:DriverHealthProfile = DriverHealthProfile()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let uid = Auth.auth().currentUser?.uid else {return}// UserID FireBase
        
    
        
        
        collectionView?.backgroundColor = .white
        navigationItem.title = "Collected Health Data"
        let button:UIButton = refreshHeathdataButton
        
         //refreshHeathdataButton.addTarget(self, action: #selector(updateHealthView),for: .touchUpInside)
        
        print(">>>firstLoad>>>>")
        loadMostRecentStats()
        items = createRecordItemList(profile: driverHealthProfile)
      //  print(items)
        
        collectionView?.register(HealthHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView?.register(HealthCell.self, forCellWithReuseIdentifier: cellId)
       collectionView.reloadData()
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 1000)
        view.addSubview(button)
        button.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 4, paddingRight: 4, width: 200, height: 50)
        
         createCloudData()
         //SetUp DHR Data
        print(">>>>>>>>HEALTH ITEMS >>>>>>>")
        print(driverHealthProfile.weight)
        //send Data between Controllers.
        delegate?.sendDriverHeathRecord(driverHealthProfile)
      // delegate?.sendDriverHeathRecord(record: driverHealthProfile)
        //update WakeUpManager
        WakeUpManager.shared.updateDHR(newDHR: driverHealthProfile)

    }
      override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HealthCell
        cell.healthDetailLabel.text = items[indexPath.item].nameOfTheHealthRecord
        cell.healthDataLabel.text = items[indexPath.item].valueOfTheHealthrecord
        
        //dateOfBirth-0/age-1/stepcount-2/distanceWalked-3/bloodType-4/weight-5/height-6/
        //activeEnergy-7/bodyMass-8/heartRate-9/biologicalSex-10/bloodGlucose-11/
        //bodyTemperature-12/xygenSaturation-13/numberOfTimesFallen - 14
        switch items[indexPath.item].imageCode {
        case  0:
             cell.healthDetailImageView.image = #imageLiteral(resourceName: "age")
        case  1:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "age")
        case  2:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "steps")
        case  3:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "distance")
        case  4:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "bloodType")
        case  5:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "weigth")
        case  6:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "heigth")
        case  7:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "activityEnergy")
        case  8:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "weigth")
        case  9:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "heartrate")
        case  10:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "male")
        case  11:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "bloodType")
        case  12:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "age")
        case  13:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "age")
        case  14:
            cell.healthDetailImageView.image = #imageLiteral(resourceName: "age")
        default: break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 66)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! HealthHeader
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    

    func loadMostRecentStats(){
        loadAgeSexAndBloodType()
        LoadgetMostRecentQuantitySample()
        
    }
    
    
//Query Body Characteristics
func loadAgeSexAndBloodType(){
    do {
        let userAgeSexAndBloodType = try Hkit.getAgeSexAndBloodType()
        
        driverHealthProfile.age = userAgeSexAndBloodType.age
        driverHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex.stringRepresentation
        driverHealthProfile.bloodType = userAgeSexAndBloodType.bloodType.stringRepresentation
        print(driverHealthProfile.biologicalSex,driverHealthProfile.bloodType,driverHealthProfile.age)
        WakeUpManager.shared.updateDHR(newDHR: driverHealthProfile)
    } catch let error {
        print(error)
    }
    
}
    
        func LoadgetMostRecentQuantitySample() {
            //return variables
    print(">>>>>>StartLoadSamplesQnatitative")
            //1. Use HealthKit to create the Height Sample Type
            guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
                print("Height Sample Type is no longer available in HealthKit")
                return
            }
            
            
            
            Hkit.getMostRecentSample(for: heightSampleType) { (sample, error) in
                guard let sample = sample else {
    
                    if let error = error {
                        print(error)
                    }
                    return
                }
                //2. Convert the height sample to meters, save to the profile model,
                //   and update the user interface.
                let unwrappedheight = sample.quantity.doubleValue(for: HKUnit.meter())
                print(">>>>>>>>>>>>>>>>unwrapController>>>>>>>>>>>>>")
                print(unwrappedheight)
                self.driverHealthProfile.height = unwrappedheight
                //self.setHeitgh(h: unwrappedheight)
                print(">>>>>>>>>>>>>>>>>>self.heigthController>>>>>>>>>>>")
                self.items = self.createRecordItemList(profile: self.driverHealthProfile)
                WakeUpManager.shared.updateDHR(newDHR: self.driverHealthProfile)
                self.collectionView.reloadData()
            }
            // Weigth
            guard let weigthSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
                print("Height Sample Type is no longer available in HealthKit")
                return
            }
            Hkit.getMostRecentSample(for: weigthSampleType) { (sample, error) in
                guard let sample = sample else {
                    
                    if let error = error {
                        print(error)
                    }
                    return
                }
                let unwrappedWheigth = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                self.driverHealthProfile.weight = unwrappedWheigth
                self.items = self.createRecordItemList(profile: self.driverHealthProfile)
                WakeUpManager.shared.updateDHR(newDHR: self.driverHealthProfile)
                self.collectionView.reloadData()
            }
            //stepcounts
           
            guard let stepCountSampleType = HKSampleType.quantityType(forIdentifier: .stepCount) else {
                print("Height Sample Type is no longer available in HealthKit")
                return
            }
            Hkit.getMostRecentSample(for: stepCountSampleType) { (sample, error) in
                guard let sample = sample else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                let unwrappedSteps = sample.quantity.doubleValue(for: HKUnit.count())
                self.driverHealthProfile.stepcount = Int(unwrappedSteps)
                self.items = self.createRecordItemList(profile: self.driverHealthProfile)
                self.collectionView.reloadData()
            }
            //distance
            guard let distanceSampleType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
                print("Height Sample Type is no longer available in HealthKit")
                return
            }
            Hkit.getMostRecentSample(for: distanceSampleType) { (sample, error) in
                guard let sample = sample else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                let unwrappedDistance = sample.quantity.doubleValue(for: HKUnit.meter())
                self.driverHealthProfile.distanceWalked = Int(unwrappedDistance)
                self.items = self.createRecordItemList(profile: self.driverHealthProfile)
                WakeUpManager.shared.updateDHR(newDHR: self.driverHealthProfile)
                self.collectionView.reloadData()
            }
            //active Callories
            guard let activeCalloriesSampleType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
                print("Height Sample Type is no longer available in HealthKit")
                return
            }
            Hkit.getMostRecentSample(for: activeCalloriesSampleType) { (sample, error) in
                guard let sample = sample else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                let unwrappedActiveCallories = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
                self.driverHealthProfile.activeEnergy = unwrappedActiveCallories
                self.items = self.createRecordItemList(profile: self.driverHealthProfile)
                WakeUpManager.shared.updateDHR(newDHR: self.driverHealthProfile)
                self.collectionView.reloadData()
                self.createCloudData()
            }
           //HeartRATE
            print(">>>>>>>>>>>>>>StopLoadSamplesQnatitative>>>>>>>>>>>>>>>")
            print(driverHealthProfile.height)
        }
 

    func createRecordItemList(profile: DriverHealthProfile) -> [HealthRecord] {
        var finalRecord = [HealthRecord]() //create and empty array of heath records
//        let record = HealthRecord(nameOfTheHealthRecord: "Date of Birth", valueOfTheHealthrecord: String(profile.dateOfBirth ?? "06.05.1991"))
//
        

//dateOfBirth-0/age-1/stepcount-2/distanceWalked-3/bloodType-4/weight-5/height-6/
//activeEnergy-7/bodyMass-8/heartRate-9/biologicalSex-10/bloodGlucose-11/
//bodyTemperature-12/xygenSaturation-13/numberOfTimesFallen - 14
        if profile.age != nil {
        var record = HealthRecord(nameOfTheHealthRecord: "Age", valueOfTheHealthrecord: String(profile.age!) ?? "28",imageCode: 1)
        
            finalRecord.append(record)
        
            record = HealthRecord(nameOfTheHealthRecord: "height", valueOfTheHealthrecord:  "\(profile.height!)",imageCode: 6)
       
            finalRecord.append(record)
            
            record = HealthRecord(nameOfTheHealthRecord: "Weigth", valueOfTheHealthrecord: "\(profile.weight!)",imageCode: 5)
            
            finalRecord.append(record)

        
       record = HealthRecord(nameOfTheHealthRecord: "Step Count", valueOfTheHealthrecord: String(profile.stepcount!) ?? "1234567",imageCode: 2)
        finalRecord.append(record)

        record = HealthRecord(nameOfTheHealthRecord: "Distance Walked", valueOfTheHealthrecord: String(profile.distanceWalked!) ?? "1234567",imageCode: 3)

        finalRecord.append(record)
        
        record = HealthRecord(nameOfTheHealthRecord: "Blood Type", valueOfTheHealthrecord: String(profile.bloodType!) ?? "A+", imageCode: 4)
        
        finalRecord.append(record)
        
        record = HealthRecord(nameOfTheHealthRecord: "Active Energy", valueOfTheHealthrecord: String(profile.activeEnergy!) ?? "34542",imageCode: 7)

        finalRecord.append(record)
            
            record = HealthRecord(nameOfTheHealthRecord: "Heart Rate", valueOfTheHealthrecord: String(profile.heartRate!) ?? "123",imageCode: 9)
            
            finalRecord.append(record)
//
//        record = HealthRecord(nameOfTheHealthRecord: "Body Mass", valueOfTheHealthrecord: String(profile.distanceWalked!) ?? "88 Kg")
//
//        finalRecord.append(record)
//
        record = HealthRecord(nameOfTheHealthRecord: "Bilogical Sex", valueOfTheHealthrecord: String(profile.biologicalSex!) ?? "Male", imageCode: 10)
        
        finalRecord.append(record)
        }
        //WakeUpManager.shared.updateDHR(newDHR: driverHealthProfile)
        return finalRecord
    
    }
    @objc func updateHealthView(){
       self.collectionView.reloadData()
        items.removeAll()
        items = createRecordItemList(profile: driverHealthProfile)
        WakeUpManager.shared.updateDHR(newDHR: driverHealthProfile)
        print(items)
        collectionView?.register(HealthHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView?.register(HealthCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
    }

    func createCloudData(){
        //todo
        print(">>>>>>>>>>>>>Printing Cloud Records >>>>>>>>>>>>>>>")
        print(items)
    }
    
    func sendDataTuHeroku(){
        //todo
    }
    //Potion for my data flow
    //func fetchUser(userID: Int, userCompletionHandler: @escaping (User?, Error?) -> Void) {
   
}

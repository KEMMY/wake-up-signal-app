//
//  UserProfileController.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 11/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

//!!!!! -- Deafulth Text user ---- email: Patrik@gmail1991.com Name: Patrik1991 Pass: qwertyu


import UIKit
import Firebase
import AVFoundation
import Alamofire
import CommonCrypto

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
   

    public static let borderColorGreen:UIColor = UIColor.rgb(red: 117, green: 160, blue: 129)
    
    
    
    //list Of Journeys
    var journeys = [JourneyRecord]()
    var alarmSoundPlayer: AVAudioPlayer?
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getJourneyHistoryForID()
        
        
        
        // HealthRecord From HealthControllerView as shared resource
        var HProfile = DriverHealthProfile()
        HProfile = WakeUpManager.shared.requestForHealthProfile()
        print(">>>>>>>>>>>>>>>>>>> Global WakeUpManager  >>>>>>>>>>")
        WakeUpManager.shared.printDHR() // trint the State Of the APP
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = Auth.auth().currentUser?.uid
        
        fetchUser()
        
        // Here is the funny JSON Part :)
        
        //journeys = createJourneyList()
        //journeys = getJourneyHistoryForID()
        
        guard let uid = Auth.auth().currentUser?.uid else {return}// UserID FireBase
        if WakeUpManager.shared.uID == "" {
            WakeUpManager.shared.updateUID(newUID: uid)
        }
        
    
        
        print(">>>>>>>>>> CURRENT USER UID >>>>>>>>>>>>>>")
        print(uid)
        print(WakeUpManager.shared.JL)
        
        //GET RERCORD BY INIT
        if WakeUpManager.shared.JL.isEmpty {
            getJourneyHistoryForID(userID: uid) { (records, error) in
                if let records = records {
                    //TODO
                    print(">>>>>>>>>>>> CLOSERE RETURNED RECORDS >>>>>>>>>>")
                    //                print(records)
                    self.journeys.append(contentsOf: records)
                    WakeUpManager.shared.JL.append(contentsOf: records)
                    print(self.journeys)
                    
                    //The UI should only be updated from main thread: Without this line you mess up the
                    
                   
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            }
        }
        

        
        self.getFatiqueByID(userID: uid) { (fatique, error) in
            guard let fatique = fatique else {return}
            WakeUpManager.shared.setFatique(newValue: fatique)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print(">>>>>>>>>>>>Reload with")
                    print(String(WakeUpManager.shared.fatique))
            }
        }
       
       
        print(">>>>>>>>>>>>>>>>>>>> Journeys List>>>>>>>>>>>>>>>")
        print(journeys)
        
        
       // journeys = createJourneyListwithYellow()
       // journeys = createJourneyListwithBlueTired()
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView?.register(UserProfileCell.self, forCellWithReuseIdentifier: cellId)
        setupLogOutButton()
        setupAlarmButton()
        //startArlarm()
       NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        collectionView.reloadData()

        //recieve data from HealthController
        
      //  perform(#selector(advanced, with: nil))
      //  startNewYourney(userID: uid)
        
     
    }
    
    @objc func loadList(notification: NSNotification) {
        startNewYourney(userID: WakeUpManager.shared.uID)
        print(">>>>>>>>>>>>>> New Journey Update to Cloud with journeyID:"+WakeUpManager.shared.newJourneyID + " >>>>>>>>>>>>>>>>>")
        sendRecordTocloud(userID: WakeUpManager.shared.uID, journeyID: WakeUpManager.shared.newJourneyID)
        self.collectionView.reloadData()
    }
    
    
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    fileprivate func setupAlarmButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "alarm").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAlarm))
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                //what happens? we need to present some kind of login controller
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                WakeUpManager.shared.JL.removeAll() // Empty Stack fo records
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleAlarm() {
        let alertController = UIAlertController(title: "You Are Tired! Take a rest", message: " Please make a stop and end the journey. Your Journey is considered as dangerous. Your MIT Team.", preferredStyle: .actionSheet)
         self.startArlarm()
        print(">>>>>>>>>>Started To Play Sound >>>>>>>>>>>>")
        
         alertController.view.subviews.last?.subviews.first?.subviews.last?.backgroundColor = UIColor.rgb(red: 255, green: 179, blue: 179)
        let AlarmTintColor = UIColor.rgb(red: 255, green: 0, blue: 0)
        alertController.view.tintColor = AlarmTintColor
        
        alertController.addAction(UIAlertAction(title: "Stop Alarm", style: .cancel, handler: { (_) in
            self.stopAlarm()
        }))
        
       // alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        //UIDevice.vibrate(duration: 2)
    }
    
     @objc func startArlarm() {
        guard let url = Bundle.main.url(forResource: "alarmSound", withExtension: "mp3") else {

        print("url not found")
            return
        }
        //let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            alarmSoundPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = alarmSoundPlayer else { return }
            
            player.play()
            //Vibration.success.vibrate()
            UIDevice.vibrate(duration: 1)
             //UIDevice.vibrate(duration: 10)
           
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
     @objc func stopAlarm() {
        
        alarmSoundPlayer?.stop()
        
    }
    
    @objc func handleEmergency(emergencyMessage: String) {
        let alertController = UIAlertController(title: "Warning this is an Emergency message!", message: emergencyMessage, preferredStyle: .actionSheet)
        self.startArlarm()
        print(">>>>>>>>>>Started To Play Sound >>>>>>>>>>>>")
        
        alertController.view.subviews.last?.subviews.first?.subviews.last?.backgroundColor = UIColor.rgb(red: 255, green: 179, blue: 179)
        let AlarmTintColor = UIColor.rgb(red: 255, green: 0, blue: 0)
        alertController.view.tintColor = AlarmTintColor
        
        alertController.addAction(UIAlertAction(title: "Stop Warning", style: .cancel, handler: { (_) in
            self.stopAlarm()
            
        }))
        
        // alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        //UIDevice.vibrate(duration: 2)
    }
        
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WakeUpManager.shared.JL.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HealthCell
//        cell.healthDetailLabel.text = items[indexPath.item].nameOfTheHealthRecord
//        cell.healthDataLabel.text = items[indexPath.item].valueOfTheHealthrecord
//
        
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfileCell
        cell.durationValueLabel.font.withSize(CGFloat(14))
        
        switch WakeUpManager.shared.JL[indexPath.item].journeyType {
        case  .green:
            cell.lastJourneyImage.image = #imageLiteral(resourceName: "ok")
            cell.lastJourneyStatusLabel.text = "Safe Journey!"
            cell.durationValueLabel.text = WakeUpManager.shared.JL[indexPath.item].duration
            cell.fatiqueValueLabel.text = "\(String(WakeUpManager.shared.JL[indexPath.item].fatiqueValue))%"
            cell.fatiqueLabel.text = WakeUpManager.shared.JL[indexPath.item].fatiqueLevel.rawValue
            cell.fatiqueLabel.textColor = UIColor.rgb(red: 117, green: 160, blue: 129)
            cell.durationLabel.textColor = UIColor.rgb(red: 117, green: 160, blue: 129)
            cell.durationValueLabel.textColor = UIColor.rgb(red: 117, green: 160, blue: 129)
            cell.lastJourneyStatusLabel.textColor = UIColor.rgb(red: 117, green: 160, blue: 129)
            cell.fatiqueValueLabel.textColor = UIColor.rgb(red: 117, green: 160, blue: 129)
            cell.backgroundColor = UIColor.rgb(red: 240, green: 245, blue: 241) //rgb(240, 245, 241)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.rgb(red: 117, green: 160, blue: 129).cgColor
        case  .red:
            cell.lastJourneyImage.image = #imageLiteral(resourceName: "error-1")
            cell.lastJourneyStatusLabel.text = "You were Tired!"
            cell.durationValueLabel.text = WakeUpManager.shared.JL[indexPath.item].duration
            cell.fatiqueValueLabel.text = "\(String(WakeUpManager.shared.JL[indexPath.item].fatiqueValue))%"
            cell.fatiqueLabel.text = WakeUpManager.shared.JL[indexPath.item].fatiqueLevel.rawValue
            cell.fatiqueLabel.textColor = UIColor.rgb(red: 236, green: 171, blue: 170)
            cell.durationLabel.textColor = UIColor.rgb(red: 236, green: 171, blue: 170)
            cell.durationValueLabel.textColor = UIColor.rgb(red: 236, green: 171, blue: 170)
            cell.lastJourneyStatusLabel.textColor = UIColor.rgb(red: 236, green: 171, blue: 170)
            cell.fatiqueValueLabel.textColor = UIColor.rgb(red: 236, green: 171, blue: 170)
            cell.backgroundColor = UIColor.rgb(red: 255, green: 230, blue: 230)  // red color
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.rgb(red: 236, green: 171, blue: 170).cgColor //icon red
        case  .yellow:
            //yellow == blue
            cell.lastJourneyImage.image = #imageLiteral(resourceName: "blue")
            cell.lastJourneyStatusLabel.text  = "   Driving!"
            cell.durationValueLabel.text = WakeUpManager.shared.JL[indexPath.item].duration
            cell.durationLabel.text = "... On Going Journey ..."
            cell.fatiqueValueLabel.text = "\(String(WakeUpManager.shared.JL[indexPath.item].fatiqueValue))%"
            cell.fatiqueLabel.text = WakeUpManager.shared.JL[indexPath.item].fatiqueLevel.rawValue
            cell.fatiqueLabel.textColor = UIColor.rgb(red: 51, green: 153, blue: 255) //rgb(51, 153, 255)
            cell.durationLabel.textColor = UIColor.rgb(red: 51, green: 153, blue: 255)
            cell.durationValueLabel.textColor = UIColor.rgb(red: 51, green: 153, blue: 255)
            cell.lastJourneyStatusLabel.textColor = UIColor.rgb(red: 51, green: 153, blue: 255)
            cell.fatiqueValueLabel.textColor = UIColor.rgb(red: 51, green: 153, blue: 255)
            cell.backgroundColor = UIColor.rgb(red: 230, green: 242, blue: 255) //230, 242, 255
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.rgb(red: 51, green: 153, blue: 255) .cgColor //yellow
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
        let width = (view.frame.width - 10)
        let heigth = CGFloat(120.0)
        return CGSize(width: width, height: heigth)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        let fl:Double = WakeUpManager.shared.fatique
        var str = ""
        if fl < 19.1 {
            str = "Very Low"
        }
        
        if fl < 39.1 && fl > 19.2 {
            str = "Low"
        }
        if fl < 69.1 && fl > 39.2 {
            str = "Moderate"
        }
        if fl < 89.1 && fl > 69.2 {
            str = "High"
        }
        if fl < 100.1 && fl > 89.2 {
            str = "Low"
        }
        
        
        if WakeUpManager.shared.fatique > 89.00 {
            
            handleAlarm()
            //startArlarm()
        }
        
        let attributedText = NSMutableAttributedString(string: String(WakeUpManager.shared.fatique)+"%\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
         header.fatiqueLabel.attributedText = attributedText
        //not correct
        //header.addSubview(UIImageView())
       
        //collectionView.reloadData()
       
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    var user: User?
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            let uid = self.user?.username as! String
            self.getJourneyHistoryForID(userID: uid) { (records, error) in
                if let records = records {
                    //TODO
                    print(">>>>>>>>>>>> CLOSERE RETURNED RECORDS >>>>>>>>>>")
                    //                print(records)
                    self.journeys.append(contentsOf: records)
                    print(self.journeys)
                    //The UI should only be updated from main thread: Without this line you mess up the
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            }
            
            
           // self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }

    //create JourneyRecords
    
    //Potion for my data flow
    //func fetchUser(userID: Int, userCompletionHandler: @escaping (User?, Error?) -> Void) {
    func getJourneyHistoryForID(userID: String, userCompletionHandler: @escaping ([JourneyRecord]?, Error?)-> Void) {
            print("<<<<<<<<<<<<<<<<Returning JSON Response from WAKE-UP-API with UserID:  >>>>>>>>>>>>>>>>>>>>>>>")
        var journeyList = [JourneyRecord]()
        guard let url = URL(string: "https://wake-up-api.herokuapp.com/journey_history") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            //        let dataAsString = String(data: data, encoding: .utf8)
            //        print(dataAsString)
            do {
                let records = try JSONDecoder().decode([JourneyHistory].self, from: data)
                print(records[0].journey_id)
                //print(records)
                var tmp:JourneyRecord = JourneyRecord(journeyId: "1", journeyType: .green, duration:"00:00", fatiqueLevel: .Moderate, fatiqueValue: 0.0)
                for i in 0..<records.count {
                    if records[i].user_id as! String == userID {
                        tmp.journeyId = records[i].journey_id as! String
                        //special case tmp.journeyType = records[i]["journey_id"] as? String
                        tmp.duration = records[i].duration as! String
                        // special case wift Fatique type
                        let fatique_type = records[i].alert_type as! String
                        if fatique_type == "Very Low" {
                            tmp.fatiqueLevel = .VeryLow
                        } else if fatique_type == "Low" {
                            tmp.fatiqueLevel = .Low
                        }else if fatique_type == "Moderate" {
                            tmp.fatiqueLevel = .Moderate
                        }else if fatique_type == "High" {
                            tmp.fatiqueLevel = .High
                        }else if fatique_type == "Very High" {
                            tmp.fatiqueLevel = .VeryHigh
                        } else {
                            tmp.fatiqueLevel = .Low
                        }
                        tmp.fatiqueValue = records[i].fatigue_perc as! Double
                        
                        //special case for color settings
                        var alt_tp = records[i].alert_type as? String
                        if alt_tp == "Medium" || alt_tp == "High" || alt_tp == "Very High" {
                            tmp.journeyType.setRed()
                        }
                        else {
                            tmp.journeyType.setGreen()
                            //}
                           // print(tmp)
                        }
                    
                        journeyList.append(tmp)
                        
                    }
                }
               // print(">>>>>>>>>>>>>>>>>>>>>> JOURNEY LIST AFTER FOR LOOP >>>>>>>>>>>>>>>>>")
               // print(journeyList)
                print(">>>>>>>>>>>>>>>>>>>>>>>>>START COMPLETION HADLER TO RETURNING JOURNEY LIST >>>>>>>>>>")
                userCompletionHandler(journeyList, nil)
                
                
                
            } catch let jsonErr {
                print("Error serializing JSON:", jsonErr)
            }
            }.resume()
        // function will end here and return
        // then after receiving HTTP response, the completionHandler will be called
        //print(">>>>>>>>>>>>>>>>JOurneyLIST>>>>>>>>>>>")
//        print(journeyList)
//        return journeyList
    }
    
    func startNewYourney(userID: String) {
        
        //Create journey_ID Hash Value.
        let uId = userID
        let sTime = getTodayString() as! String
        print(sTime)
        let eTime = getTodayString() as! String
        let duration = "00:00:00" // 2019-09-20T12:23:54
        let distance = 100 //This will be calculated by MAP-Controller Not Yet included
        let fatiqueLevel = 0
        let alertType = "Very Low"
        let fatiquePerc = 0.0
        let data:String = uId + sTime + eTime + duration + String(distance) + String(fatiqueLevel) + alertType + String(fatiquePerc)
        let md5Data = MD5(string:data)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        let jId = md5Hex
        WakeUpManager.shared.newJourneyID = jId
        
        let parameters: Parameters = [
            "journey_id": jId,
            "user_id": uId,
            "start_time": sTime,
            "end_time": eTime,
            "duration": duration,
            "distance": distance,
            "fatigue_level": fatiqueLevel,
            "alert_type": alertType,
            "fatigue_perc":  fatiquePerc
        ]
        print(">>>>>>>>>>>>>>>>>>>> JSON REQUEST BODY >>>>>>>>>>>>>>>>")
        Alamofire.request("https://wake-up-api.herokuapp.com/journey_history", method: .post, parameters: parameters).responseJSON { response in
            print(">>>>>>>>>>> RESPONSE >>>>>>>>>>>>")
            print(response)
        }
        
    }
    
    func  sendRecordTocloud(userID: String, journeyID: String) {
 
        let parameters: Parameters = [
            "age": WakeUpManager.shared.DHR.age!, // integer
            "height": WakeUpManager.shared.DHR.height!, // double
            "weight": WakeUpManager.shared.DHR.weight!, // double
            "stepCount": WakeUpManager.shared.DHR.stepcount!, //double
            "distanceWalked": WakeUpManager.shared.DHR.distanceWalked!, //double
            "bloodType": WakeUpManager.shared.DHR.bloodType!, //varchar
            "activeEnergy": WakeUpManager.shared.DHR.activeEnergy!, //double
            "heartRate": WakeUpManager.shared.DHR.heartRate!, //double
            "bilogicalSex":  WakeUpManager.shared.DHR.biologicalSex!, //varchar
            "user_id": userID, //varchar
            "journey_id": journeyID //varchar
        ]
        print(">>>>>>>>>>>>>>>>>>>> JSON REQUEST BODY >>>>>>>>>>>>>>>>")
        Alamofire.request("https://wake-up-api.herokuapp.com/driver_health_record", method: .post, parameters: parameters).responseJSON { response in
            print(">>>>>>>>>>> RESPONSE >>>>>>>>>>>>")
            print(response)
        }
    }
    
    //fatique
    
    func getFatiqueByID(userID: String, userCompletionHandler: @escaping (Double?, Error?)-> Void) {

        print("<<<<<<<<<<<<<<<<Returning Fatique JSON Response from WAKE-UP-API with UserID:  >>>>>>>>>>>>>>>>>>>>>>>")
        var fatique:Double = 0.0
        guard let url = URL(string: "https://wake-up-api.herokuapp.com/driver_fatigue") else {return}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                let fatiqueRecords = try JSONDecoder().decode([FatiqueJSON].self, from: data)
                print(fatiqueRecords[0].fatigue)
                print("Hope not nil")
                for i in 0..<fatiqueRecords.count {
                    if fatiqueRecords[i].uid as! String == userID {
                        fatique = fatiqueRecords[i].fatigue
                    }
                }
                userCompletionHandler(fatique, nil)
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
       
    }
}



struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }

}

// Generate MD5 value

func MD5(string: String) -> Data {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    let messageData = string.data(using:.utf8)!
    var digestData = Data(count: length)
    
    _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
        messageData.withUnsafeBytes { messageBytes -> UInt8 in
            if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                let messageLength = CC_LONG(messageData.count)
                CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
            }
            return 0
        }
    }
    return digestData
}

func getTodayString() -> String{
    
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
    let year = components.year
    let month = components.month
    let day = components.day
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
    return today_string
    
}


    








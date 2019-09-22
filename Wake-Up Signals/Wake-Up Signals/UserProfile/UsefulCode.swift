//
//  JSONHandler.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 19/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

 // fatique_type == "Very Low" <1-19> / "Low" <20-39> / "Moderate" <40-69> / "High" <70-89> / "Very High" <89-100>










//            guard let alert_type = jsonArray[0]["alert_type"] as? String else { return }
//            print(alert_type)
//            guard let user_id = jsonArray[0]["user_id"] as? String else { return }
//            print(user_id)
//            guard let distance = jsonArray[0]["distance"] as? Int else { return }
//            print(distance)
//            guard let end_time = jsonArray[0]["end_time"] as? String else { return }
//            print(end_time)
            

// entrance templates :


//func createJourneyListwithYellow() ->  [JourneyRecord]{
//    // createJourneyList(Journey){ ...}
//    var journeyList = [JourneyRecord]()
//    var record = JourneyRecord(journeyId: "1", journeyType: .yellow, duration: "0h 00m 59s", fatiqueLevel: .VeryLow, fatiqueValue: 1)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "2", journeyType: .green, duration: "3h 1m 10s", fatiqueLevel: .Moderate, fatiqueValue: 30)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "3", journeyType: .red, duration: "1h 13m 59s", fatiqueLevel: .VeryHigh, fatiqueValue: 83)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "4", journeyType: .green, duration: "4h 21m 48s", fatiqueLevel: .Moderate, fatiqueValue: 63)
//    journeyList.append(record)
//    return journeyList
//}

//func createJourneyListwithBlueTired() ->  [JourneyRecord]{
//    // createJourneyList(Journey){ ...}
//    var journeyList = [JourneyRecord]()
//    var record = JourneyRecord(journeyId: "1", journeyType: .yellow, duration: "5h 13m 59s", fatiqueLevel: .VeryLow, fatiqueValue: 94.4)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "2", journeyType: .green, duration: "3h 1m 10s", fatiqueLevel: .Moderate, fatiqueValue: 30)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "3", journeyType: .red, duration: "1h 13m 59s", fatiqueLevel: .VeryHigh, fatiqueValue: 83)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "4", journeyType: .green, duration: "4h 21m 48s", fatiqueLevel: .Moderate, fatiqueValue: 63)
//    journeyList.append(record)
//    return journeyList
//}



//json handler:
//
//print(">>>>>>>>>>>>>>>>>>>>>>>> JOURNEY ID >>>>>>>>>>>>>>>>>>>>>")
//guard let j_id = jsonArray[0]["journey_id"] as? String else { return }
//print(j_id)
////            example of other types parsing
//// create JourneyRecord object and add into jr list.
//var tmp:JourneyRecord = JourneyRecord(journeyId: "1", journeyType: .green, duration:"00:00", fatiqueLevel: .Moderate, fatiqueValue: 0.0)
//let rows = jsonArray.count
//for i in 0...3 {
//    tmp.journeyId = jsonArray[i]["journey_id"] as! String
//    //special case tmp.journeyType = jsonArray[i]["journey_id"] as? String
//    tmp.duration = jsonArray[i]["duration"] as! String
//    // special case wift Fatique type
//    let fatique_type = jsonArray[i]["alert_type"] as! String
//    if fatique_type == "Very Low" {
//        tmp.fatiqueLevel = .VeryLow
//    } else if fatique_type == "Low" {
//        tmp.fatiqueLevel = .Low
//    }else if fatique_type == "Moderate" {
//        tmp.fatiqueLevel = .Moderate
//    }else if fatique_type == "High" {
//        tmp.fatiqueLevel = .High
//    }else if fatique_type == "Very High" {
//        tmp.fatiqueLevel = .VeryHigh
//    } else {
//        tmp.fatiqueLevel = .Low
//    }
//    tmp.fatiqueValue = jsonArray[i]["fatigue_perc"] as! Double
//
//    //special case for color settings
//    var alt_tp = jsonArray[i]["alert_type"] as? String
//    if alt_tp == "Medium" || alt_tp == "High" || alt_tp == "Very High" {
//        tmp.journeyType.setRed()
//    }
//    else {
//        tmp.journeyType.setGreen()
//    }
//    //add tmp in the lisdt
//    print(">>>>>>>>>>>>>>TMP Value>>>>>>>>>")
//    print(tmp)
//    journeyList.append(tmp)
//}


//journeyHistory.append(contentsOf: records)
//var tmp:JourneyRecord = JourneyRecord(journeyId: "1", journeyType: .green, duration:"00:00", fatiqueLevel: .Moderate, fatiqueValue: 0.0)
//// for i in 1..<records.count-1 {
//tmp.journeyId = records[1].journey_id as! String
////special case tmp.journeyType = records[i]["journey_id"] as? String
//tmp.duration = records[1].duration as! String
//// special case wift Fatique type
//let fatique_type = records[1].alert_type as! String
//if fatique_type == "Very Low" {
//    tmp.fatiqueLevel = .VeryLow
//} else if fatique_type == "Low" {
//    tmp.fatiqueLevel = .Low
//}else if fatique_type == "Moderate" {
//    tmp.fatiqueLevel = .Moderate
//}else if fatique_type == "High" {
//    tmp.fatiqueLevel = .High
//}else if fatique_type == "Very High" {
//    tmp.fatiqueLevel = .VeryHigh
//} else {
//    tmp.fatiqueLevel = .Low
//}
//tmp.fatiqueValue = records[1].fatigue_perc as! Double
//
////special case for color settings
//var alt_tp = records[1].alert_type as? String
//if alt_tp == "Medium" || alt_tp == "High" || alt_tp == "Very High" {
//    tmp.journeyType.setRed()
//}
//else {
//    tmp.journeyType.setGreen()
//    //}
//    print(tmp)
//    print("JOurneyList")
//    print(journeyHistory)
//
//}



//func createJourneyList() ->  [JourneyRecord]{
//    // createJourneyList(Journey){ ...}
//    var journeyList = [JourneyRecord]()
//    var record = JourneyRecord(journeyId: "1", journeyType: .green, duration: "1h 13m 59s", fatiqueLevel: .VeryLow, fatiqueValue: 14.4)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "2", journeyType: .green, duration: "3h 1m 10s", fatiqueLevel: .Moderate, fatiqueValue: 30.5)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "3", journeyType: .red, duration: "5h 13m 59s", fatiqueLevel: .VeryHigh, fatiqueValue: 90.2)
//    journeyList.append(record)
//    record = JourneyRecord(journeyId: "4", journeyType: .green, duration: "4h 21m 48s", fatiqueLevel: .High, fatiqueValue: 78.1)
//    journeyList.append(record)
//    return journeyList
//}

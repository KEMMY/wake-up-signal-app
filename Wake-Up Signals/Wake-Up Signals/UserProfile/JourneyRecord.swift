//
//  JourneyRecord.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 8/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//
import Foundation


struct JourneyRecord {
    var journeyId: String
    var journeyType: journeyType //.green, .red, .yellow
    var duration: String // Time in string
    var fatiqueLevel: fatique //Moderate
    var fatiqueValue: Double // 23.7%
    
//    init() {
//        // perform some initialization here
//        self.journeyId = "001"
//        self.journeyType = .green //.green, .red, .yellow
//        self.duration = "00:00:00"// Time in string
//        self.fatiqueLevel =  .VeryLow //Moderate
//        self.fatiqueValue = 0.0
//    }
}

enum fatique: String {
    case VeryLow = "Very Low"
    case Low = "Low"
    case Moderate = "Moderate"
    case High = "High"
    case VeryHigh = "Very High"
}

enum journeyType {
    case green, red, yellow
    mutating func setGreen() {
        self = .green
    }
    mutating func setRed() {
        self = .red
    }
    mutating func setYellow() {
        self = .yellow
    }
}

public struct JourneyHistory: Codable {
    let journey_id: String?
    let user_id: String?
    let start_time: String? //Date?
    let end_time: String? //Date?
    let duration: String? //TimeInterval?
    let distance: Int?
    let fatique_level: Int?
    let alert_type: String?
    let fatigue_perc: Double?
    
    init(journey_id: String?="", user_id: String?="",start_time: String?="00:00:00", end_time: String?="00:00:00", duration: String?="00:00:00", distance: Int?=0, fatique_level: Int?=0, alert_type: String?="Very Low", fatigue_perc: Double?=0.0) {
        self.journey_id = journey_id
        self.user_id = user_id
        self.start_time = start_time
        self.end_time = end_time
        self.duration = duration
        self.distance = distance
        self.fatique_level = fatique_level
        self.alert_type = alert_type
        self.fatigue_perc = fatigue_perc
    }
}




//Comformed JSON Format
//
//[
//    {
//        "journey_id": "a639d6f84e1ff2589921e6a6fd9db3f3",
//        "user_id": "BnuNMdxjJQg7t4gPtc3g1cXQZY82",
//        "start_time": "2019-09-19T10:23:54",
//        "end_time": "2019-09-19T11:23:54",
//        "duration": "01:00:00",
//        "distance": 100,
//        "fatigue_level": 2,
//        "alert_type": "Very Low",
//        "fatigue_perc": 14.56
//    },
//Comformed JSON format
//    {
//        "uid": "TIxbuAGNw8TPLRYz49v3fuvgpJC3",
//        "fatigue": 46.4
//    },

//
//  EmergencyJSON.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 23/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

public struct EmergencyJSON: Decodable {
    let uid: String
    let alerting: Bool
    let alerts_count: Int
    let emergency: Bool
    let emergency_: String
    
    
    init(user_uid: String, user_alerting: Bool, user_alerts_counts: Int, user_emergency: Bool, user_emergency_: String) {
        self.uid = user_uid
        self.alerting = user_alerting
        self.alerts_count = user_alerts_counts
        self.emergency = user_emergency
        self.emergency_ = user_emergency_
    }
}

//Conforming JSON pattern :
//{
//    "uid": "FmMOKMRi3UTsGtoPcIerimE0Zon2",
//    "alerting": true,
//    "alerts_count": 1,
//    "emergency": true,
//    "emergency_": "No Emergency."
//},

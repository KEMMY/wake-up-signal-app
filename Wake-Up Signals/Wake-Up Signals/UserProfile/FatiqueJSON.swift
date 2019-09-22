//
//  FatiqueJSON.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 21/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

public struct FatiqueJSON: Decodable {
    let uid: String
    let fatigue: Double
    init(user_id: String, fatique: Double) {
        self.uid = user_id
        self.fatigue = fatique
    }
}

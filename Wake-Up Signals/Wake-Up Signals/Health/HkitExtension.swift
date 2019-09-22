//
//  HkitExtension.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 4/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation
import HealthKit

extension HKBiologicalSex {
    
    var stringRepresentation: String {
        switch self {
        case .notSet: return "NotSet"
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        }
    }
}


extension HKBloodType {
    
    var stringRepresentation: String {
        switch self {
        case .notSet: return "Unknown"
        case .aPositive: return "A+"
        case .aNegative: return "A-"
        case .bPositive: return "B+"
        case .bNegative: return "B-"
        case .abPositive: return "AB+"
        case .abNegative: return "AB-"
        case .oPositive: return "O+"
        case .oNegative: return "O-"
        }
    }
}

//
//  gender.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 4/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

//Body Characteristics

enum gender {
    case male,female
    mutating func setMale() {
        self = .male
    }
    mutating func setFemale() {
            self = .female
    }
}

enum bloodType {
    case A,B,AB,O
}

enum rHFactor {
    case positive,negative
    mutating func setNegative() {
        self = .negative
    }
    mutating func positive() {
        self = .positive
    }
}

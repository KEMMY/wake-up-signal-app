//
//  DataDelegate.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 20/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation

protocol DataDelegate {
    func sendDriverHeathRecord(_ record: DriverHealthProfile)
}

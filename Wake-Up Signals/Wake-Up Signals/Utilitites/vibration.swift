//
//  Vibration.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 8/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import AVFoundation
import UIKit

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool
    
    func vibrate() {
        
        switch self {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
    }
    
}

extension UIDevice {
    static func vibrate(duration: Int?) {
        
        
        if duration != nil {
        var i:Int = 1
        while i < duration! {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            i = i+1
            sleep(1)
            print(i)
        }
      }
    }
}

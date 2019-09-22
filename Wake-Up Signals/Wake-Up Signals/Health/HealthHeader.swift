//
//  UserHealthHeader.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 18/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import Foundation
import UIKit

class HealthHeader: UICollectionViewCell {
    
    let Hkit = HealtKitManager()
    
    let authHKLabel: UILabel = {
        let label = UILabel()
        label.text = "Authorize Health Data"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let authorizeHealthDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Authorize", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupHeaderView()
        authorizeHealthDataButton.addTarget(self, action: #selector(authHkit),for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func SetupHeaderView() {
        let stackView = UIStackView(arrangedSubviews: [authorizeHealthDataButton, authHKLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
           stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: frame.width - 20, height: 50)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.spacing = 10
    }
    

    @objc func authHkit() {
    print("AuthHK pressed")
        Hkit.authorizeHealthKit { (authorize, error) in
            guard authorize else {
                let message = "HealthKit Authorization failed"
                if let error = error {
                    print("\(message). Error:  \(error.localizedDescription)")
                } else {
                    print(message)
                }
                return
            }
            print("HealthKit Authorisation Successfull!")
        }
       //if auhtorize data allowed = Dismis authorize button!
}

}

//
//  UserHeader.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 11/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    
    var user: User? {
        didSet {
            setupProfileImage()
            
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let tirenessLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Tiredness\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Level", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let fatiqueLabel: UILabel = {
        let label = UILabel()
        // fatique_type == "Very Low" <1-19.1> / "Low" <19.2-39.1> / "Moderate" <39.2-69.1> / "High" <69.2-89.1> / "Very High" <89.2-100>
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
        
        let attributedText = NSMutableAttributedString(string: String(WakeUpManager.shared.fatique)+"%\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let startJourneyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start New Journey", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        //button.addTarget(self, action: #selector(handleNewJourney), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleNewJourney),for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        startJourneyButton.addTarget(self, action: #selector(handleNewJourney), for: .touchUpInside)
        
        addSubview(profileImageView)
       
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 17, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
       // setupBottomToolbar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        setupUserStatsView()
        
        addSubview(startJourneyButton)
        startJourneyButton.anchor(top: tirenessLabel.bottomAnchor, left: tirenessLabel.leftAnchor, bottom: nil, right: fatiqueLabel.rightAnchor, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 34)
        
       
        
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [tirenessLabel, fatiqueLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
    }
    
   
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }
            
            //perhaps check for response status of 200 (HTTP OK)
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            }.resume()
    }
    
    @objc fileprivate func handleNewJourney() {
        print(">>>>>>>>>>>>>>>>> New Journey Button Was Pressed >>>>>>>>>>>>>>")
        print(">>> Adding New Journey Into WakeUpManager >>>")
       
        let fl:Double = WakeUpManager.shared.fatique
        var str:fatique = .Low
        if fl < 19.1 {
            str = .VeryLow
        }
        
        if fl < 39.1 && fl > 19.2 {
            str = .Low
        }
        if fl < 69.1 && fl > 39.2 {
            str = .Moderate
        }
        if fl < 89.1 && fl > 69.2 {
            str = .High
        }
        if fl < 100.1 && fl > 89.2 {
            str = .VeryHigh
        }
        
        let data:String = WakeUpManager.shared.requestDHRHash() + randomString(length: 16) // randomString is like Salt
        let md5Data = MD5(string:data)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        let newJourney = JourneyRecord(journeyId: md5Hex, journeyType: .yellow, duration: "Click to End Journey", fatiqueLevel: str , fatiqueValue: WakeUpManager.shared.fatique)
        WakeUpManager.shared.JL.insert(newJourney, at: 0)
        print(newJourney.journeyId)
        WakeUpManager.shared.newJourneyON() //turn On new Journey
        
        //startJourneyButton.isEnabled = false
        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        startJourneyButton.isEnabled = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
   
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

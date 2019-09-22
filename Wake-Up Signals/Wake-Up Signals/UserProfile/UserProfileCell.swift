//
//  UserProfileCell.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 6/9/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

//This Cell represent one Journey isntance with this journey description

import Foundation
import UIKit

//Color pallete
// Border Green: 117/160/129
// Filling Green: 193/222/192


class UserProfileCell: UICollectionViewCell {
    
   public static let colorGreen:UIColor = UIColor.rgb(red: 117, green: 160, blue: 129)
    
    
    let lastJourneyImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let lastJourneyStatusLabel: UILabel = {
        let label = UILabel()
        //label.text = "Step count"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = colorGreen
        return label
    }()
    
   
    
    let durationValueLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "2h 36m 16s\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        
//        attributedText.append(NSAttributedString(string: "Duration", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.textColor = colorGreen
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Duration", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        label.attributedText = attributedText
        label.textColor = colorGreen
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let fatiqueValueLabel: UILabel = {
        let label = UILabel()
        label.text = "23%"
        let attributedText = NSMutableAttributedString(string: "24%", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        label.attributedText = attributedText
        label.textColor = colorGreen
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let fatiqueLabel: UILabel = {
        let label = UILabel()
//        let attributedText = NSMutableAttributedString(string: "23%\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
//
//        attributedText.append(NSAttributedString(string: "Low", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        //label.attributedText = attributedText
        label.text = "Low"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = colorGreen
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(lastJourneyImage)
        addSubview(lastJourneyStatusLabel)
        
        
        lastJourneyImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        lastJourneyImage.layer.cornerRadius = 80 / 2
        lastJourneyImage.clipsToBounds = true
        lastJourneyImage.image = #imageLiteral(resourceName: "ok")
        
        // setupBottomToolbar()
        
        addSubview(lastJourneyStatusLabel)
        lastJourneyStatusLabel.anchor(top: lastJourneyImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        lastJourneyStatusLabel.text = "Safe Journey!"
        
        //journey stats
        
        addSubview(durationValueLabel)
        durationValueLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(durationLabel)
         durationLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -6, paddingRight: 0, width: 0, height: 0)
        
        addSubview(fatiqueValueLabel)
         fatiqueValueLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        addSubview(fatiqueLabel)
           fatiqueLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -6, paddingRight: 30, width: 0, height: 0)
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

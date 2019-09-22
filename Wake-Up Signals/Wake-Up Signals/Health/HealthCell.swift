//
//  UserHealthCell.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 18/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import UIKit

class HealthCell: UICollectionViewCell {
   
    let healthDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let healthDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Step count"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let healthDataLabel: UILabel = {
        let label = UILabel()
        label.text = "1000"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let separatorView: UIView = {
       let view = UIView()
       view.backgroundColor = UIColor(white: 0, alpha: 0.5)
       return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .yellow
        
        addSubview(healthDetailImageView)
        addSubview(healthDetailLabel)
        addSubview(healthDataLabel)
        addSubview(separatorView)
        
        healthDetailImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
        healthDetailImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        healthDetailLabel.anchor(top: topAnchor, left: healthDetailImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        healthDataLabel.anchor(top: topAnchor, left:  nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        
        separatorView.anchor(top: nil, left: healthDetailLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

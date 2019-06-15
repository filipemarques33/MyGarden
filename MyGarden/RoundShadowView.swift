//
//  RoundShadowView.swift
//  MyGarden
//
//  Created by Filipe Marques on 13/06/19.
//  Copyright © 2019 Filipe Marques. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 8
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 233/255, green: 236/255, blue: 239/255, alpha: 1.0).cgColor
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor(red: 233/255, green: 236/255, blue: 239/255, alpha: 1.0).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 1.0
            shadowLayer.shadowRadius = 0.0
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }}

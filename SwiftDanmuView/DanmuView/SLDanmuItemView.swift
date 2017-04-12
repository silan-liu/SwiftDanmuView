//
//  SLDanmuItemView.swift
//  SwiftDanmuView
//
//  Created by liusilan on 2017/4/12.
//  Copyright © 2017年 silan. All rights reserved.
//

import Foundation
import UIKit

class SLDanmuItemView: UIView {
    var label: UILabel?
    let leftMargin: CGFloat = 10
    let topMargin: CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        label = UILabel()
        
        if let label = label {
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.black
            
            label.text = "what"
            self.addSubview(label)
        }
    }
    
    func updateText(text: String) {
        if let label = label {
            label.text = text
            self.setNeedsLayout()
        }
    }
    
    func updateAttributedText(text: NSAttributedString) {
        if let label = label {
            label.attributedText = text
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let label = label {
            label.sizeToFit()
            
            label.frame = CGRect(x: leftMargin, y: topMargin, width: label.frame.size.width, height: label.frame.size.height)
            
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: label.frame.size.width + 2 * leftMargin, height: label.frame.size.height + 2 * topMargin)
        }
    }
}

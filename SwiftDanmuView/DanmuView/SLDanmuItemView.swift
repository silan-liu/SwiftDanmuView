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

    typealias T = SLDanmuInfo
    
    let leftMargin: CGFloat = 10
    let topMargin: CGFloat = 5
    
    lazy var defaultHeight: CGFloat = {
        let text: NSString = "#"
        let constraintRect = CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))
        
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: self.label.font], context: nil)
        
        return boundingBox.height
    }()
    
    lazy var label: UILabel = {
        var label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addSubview(label)
    }
    
    func updateDanmuInfo(info: SLDanmuInfo) {
        label.text = info.text
        label.textColor = info.textColor
        
        setNeedsLayout()
    }
    
    func updateAttributedText(text: NSAttributedString) {
        label.attributedText = text
        setNeedsLayout()
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        
        label.sizeToFit()
        
        label.frame = CGRect(x: leftMargin, y: topMargin, width: label.frame.size.width, height: label.frame.size.height)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: label.frame.size.width + 2 * leftMargin, height: label.frame.size.height + 2 * topMargin)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sizeToFit()
    }
}

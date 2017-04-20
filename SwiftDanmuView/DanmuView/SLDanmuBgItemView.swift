//
//  SLDanmuBgItemView.swift
//  SwiftDanmuView
//
//  Created by liusilan on 2017/4/19.
//  Copyright © 2017年 silan. All rights reserved.
//

import Foundation
import UIKit

class SLDanmuBgItemView: SLDanmuItemView {
    
    typealias T = SLBgDanmuInfo
    
    lazy var bgView: UIView = {
        var bgView = UIView()
        
        bgView.backgroundColor = UIColor.lightGray
        bgView.layer.cornerRadius = 4
        bgView.clipsToBounds = true
        
        return bgView
    }()

    override func commonInit() {
        super.commonInit()
        self.insertSubview(bgView, belowSubview: label)
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        bgView.frame = self.bounds
    }
    
   
    override func updateDanmuInfo(info: SLDanmuInfo) {
        super.updateDanmuInfo(info: info)
    
        if let info = info as? SLBgDanmuInfo {
            bgView.backgroundColor = info.bgColor
        }
    }
}

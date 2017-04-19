//
//  SLDanmuInfo.swift
//  SwiftDanmuView
//
//  Created by liusilan on 2017/4/17.
//  Copyright © 2017年 silan. All rights reserved.
//

import Foundation
import UIKit

struct SLDanmuInfo {
    var text: String
    var textColor: UIColor = UIColor.black
    var itemViewClass: AnyClass = SLDanmuItemView.self
    
    init(text aText: String) {
        text = aText
    }
    
    init(text aText: String, textColor aTextColor: UIColor) {
        text = aText
        textColor = aTextColor
    }
    
    init(text aText: String, textColor aTextColor: UIColor, itemViewClass aItemViewClass: AnyClass) {
        text = aText
        textColor = aTextColor
        itemViewClass = aItemViewClass
    }
}

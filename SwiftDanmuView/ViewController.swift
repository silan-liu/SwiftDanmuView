//
//  ViewController.swift
//  SwiftDanmuView
//
//  Created by liusilan on 2017/4/12.
//  Copyright © 2017年 silan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let danmuView = SLDanmuItemView(frame: CGRect(x: 0, y: 50, width: 0, height: 0))
        
        danmuView.backgroundColor = UIColor.red
        danmuView.updateText(text: "99230")
        self.view.addSubview(danmuView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  SwiftDanmuView
//
//  Created by liusilan on 2017/4/12.
//  Copyright © 2017年 silan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var danmu: SLDanmuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        danmu = SLDanmuView(frame: CGRect(x: 0, y: 50, width: self.view.width, height: 150))
        
        self.view.addSubview(danmu!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        danmu?.pause()
    }
    
    @IBAction func resumeAction(_ sender: Any) {
        danmu?.resume()
    }
    
}


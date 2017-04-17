//
//  SLDanmuView.swift
//  SwiftDanmuView
//
//  Created by liusilan on 2017/4/12.
//  Copyright © 2017年 silan. All rights reserved.
//

import Foundation
import UIKit

class SLDanmuView: UIView {
    // 轨道间距
    let lineSpace: CGFloat = 25.0
    
    // 轨道数
    var numberOfRows: UInt = 3
    
    // 速度
    var speed: CGFloat = 75.0
    
    var timer: Timer?
    
    lazy var pendingList: [SLDanmuInfo] = {
        var list = Array<SLDanmuInfo>()
        
        //test
        var info = SLDanmuInfo(text: "hi色黑龙江凡士林", textColor: UIColor.red)
        list.append(info)
        
        info = SLDanmuInfo(text: "arre咳咳咳看", textColor: UIColor.blue)
        list.append(info)

        info = SLDanmuInfo(text: "fds分手快乐发送", textColor: UIColor.black)
        list.append(info)

        info = SLDanmuInfo(text: "23诶偶无偶", textColor: UIColor.purple)
        list.append(info)
        
        info = SLDanmuInfo(text: "ff你好风刀霜剑反馈塑料袋交付的考四六级", textColor: UIColor.green)
        list.append(info)
        
        info = SLDanmuInfo(text: "ff你好风刀霜剑发快递扩扩扩扩塑料袋交付的考四六级", textColor: UIColor.yellow)
        list.append(info)
        
        return list
    }()
    
    lazy var reuseItemViewSet: Set<SLDanmuItemView> = {
        var set = Set<SLDanmuItemView>()
        return set
    }()
    
    // 最后一条弹幕完全显示在屏幕上的时间记录
    lazy var timeDict: [Int: CGFloat] = {
        var dict = [Int: CGFloat]()
        return dict
    }()
    
    //MARK:init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        commonInit()
    }
    
    func commonInit() {
        startTimer()
    }
    
    //MARK: timer
    func startTimer() {
        if let timer = timer {
            timer.invalidate()
        }
        
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(SLDanmuView.handleTimer), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        timer!.fire()
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    func handleTimer() {
        guard pendingList.count > 0 else {
            return
        }
        
        if let info = pendingList.first {
            playDanmu(info: info)
            pendingList.remove(at: 0)
        }
    }
    
    //MARK:play danmu
    func rowHeight() -> CGFloat {
        return (self.height - lineSpace * CGFloat((numberOfRows - 1))) / CGFloat(numberOfRows)
    }
    
    func rowWithY(y: CGFloat) -> Int {
        return Int(y / (rowHeight() + lineSpace))
    }
    
    func playDanmu(info: SLDanmuInfo) {
        guard info.text.characters.count > 0 else {
            return
        }
        
        // 随机取条弹轨
        let index: Int = Int(arc4random() % UInt32(numberOfRows))
        
        // 判断是否能放在该条轨道，即该轨道的最后一条弹幕已经在屏幕上。
        var shouldShow = true
        if let time = timeDict[index] {
            let currentTime = NSDate()
            if currentTime.timeIntervalSince1970 < TimeInterval(time) {
                shouldShow = false
            }
        }
        
        guard shouldShow else {
            pendingList.append(info)
            return
        }
        
        var itemView = dequeueItemView()
        if itemView == nil {
            itemView = SLDanmuItemView()
        }
        
        // 计算坐标y
        let y =  CGFloat(index) * (lineSpace + rowHeight())
        itemView!.x = self.frame.size.width
        itemView!.y = y

        itemView!.updateDanmuInfo(info: info)
        itemView!.sizeToFit()
        
        self.addSubview(itemView!)
        
        // 弹幕完全显示在屏幕的时间+间隔
        let time = itemView!.width / speed + 0.5 + CGFloat(NSDate().timeIntervalSince1970)
        timeDict[index] = time
        
        // 动画
        let duration = (self.width + itemView!.width) / speed
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveLinear, animations: {
            itemView!.x = -itemView!.width
        }) { (finished) in
            if (finished) {
                self.reuseItemViewSet.insert(itemView!)
                itemView!.removeFromSuperview()
            }
        }
    }
    
    func dequeueItemView() -> SLDanmuItemView? {
        guard reuseItemViewSet.count > 0 else {
            return nil
        }
        
        let itemView = reuseItemViewSet.first
        reuseItemViewSet.removeFirst()
        
        print("resuse itemView")
        return itemView
    }
    
    func pause() {
        stopTimer()
        
        for itemView in self.subviews {
            if itemView.isKind(of: SLDanmuItemView.self) {
                if let frame = itemView.layer.presentation()?.frame {
                    itemView.frame = frame
                }
                
                itemView.layer.removeAllAnimations()
            }
        }
    }
    
    func resume() {
        startTimer()
        
        for itemView in self.subviews {
            if itemView.isKind(of: SLDanmuItemView.self) {
                let index = rowWithY(y: itemView.y)
                
                
                // 更新时间，右边未完全显示在屏幕
                if (itemView.x + itemView.width > self.width) {
                    let time = (itemView.x + itemView.width - self.width) / speed + 0.5 + CGFloat(NSDate().timeIntervalSince1970)
                    timeDict[index] = time
                }
                
                let duration = (itemView.x + itemView.width) / speed
                
                UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveLinear, animations: {
                    itemView.x = -itemView.width
                }) { (finished) in
                    if (finished) {
                        self.reuseItemViewSet.insert(itemView as! SLDanmuItemView)
                        itemView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func reset() {
        stopTimer()

        reuseItemViewSet.removeAll()
        pendingList.removeAll()
        timeDict.removeAll()
    }
}

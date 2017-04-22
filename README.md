

用swift3.1编写的弹幕组件，效果如下。

![danmugif](danmu.gif)

####使用

设置好数据源即可。

```
class ViewController: UIViewController {
	
    lazy var danmuView: SLDanmuView = {
        var danmuView = SLDanmuView(frame: CGRect(x: 0, y: 50, width: self.view.width, height: 150))
        return danmuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var list = [SLDanmuInfo]()
        
        //test
        var info = SLDanmuInfo(text: "hi色黑龙江凡士林", textColor: UIColor.red, itemViewClass: SLDanmuBgItemView.self)
        list.append(info)
        
        info = SLDanmuInfo(text: "arre咳咳咳看", textColor: UIColor.blue, itemViewClass: SLDanmuItemView.self)
        list.append(info)
        
        info = SLDanmuInfo(text: "fds分手快乐发送", textColor: UIColor.black, itemViewClass: SLDanmuBgItemView.self)
        list.append(info)
        
        info = SLDanmuInfo(text: "23诶偶无偶", textColor: UIColor.purple, itemViewClass: SLDanmuItemView.self)
        list.append(info)
        
        for i in 0...10 {
            info = SLDanmuInfo(text: "考四六级" + String(i), textColor: UIColor.red, itemViewClass: SLDanmuItemView.self)
            list.append(info)
        }
        
        danmuView.pendingList.append(contentsOf: list)
	
        self.view.addSubview(danmuView)
    }
```


####自定义弹幕ui

同时也可以自定义弹幕ui继承自`SLDanmuItemView`，danmuInfo继承`SLDanmuInfo`，在自定义ui中更新danmuInfo。
	
```
class SLDanmuBgItemView: SLDanmuItemView {
	override func updateDanmuInfo(info: SLDanmuInfo) {
	        super.updateDanmuInfo(info: info)
	    
	        if let info = info as? SLBgDanmuInfo {
	            bgView.backgroundColor = info.bgColor
	        }
	    }
}
```
	
```
class SLBgDanmuInfo: SLDanmuInfo {
    var bgColor: UIColor
    ...
}
```




# RanGuidePages
新手引导页

## 常用的新手引导
### 使用方法 , 只需要传图片数组

      
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //没有登录过
        guard (UserDefaults.standard.value(forKey: "launched") != nil) else {
            let images = ["1.jpg","2.jpg","3.jpg"]
            let ranGuide = RanGuidePages(frame: UIScreen.main.bounds, images: images)
            self.view.addSubview(ranGuide)
            //登录过
            UserDefaults.standard.set("launch", forKey: "launched")
            return
        }
    }
### 增加自动滚动功能
        autoScrollTime = 2 
    

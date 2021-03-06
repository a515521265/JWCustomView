//
//  TextSwiftViewController.swift
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/31.
//
//

import UIKit

class TextSwiftViewController: UIViewController {

    let JkScreenWidth = UIScreen.main.bounds.size.width
    let JkScreenheight = UIScreen.main.bounds.size.height
    
    
    
    //变量
    var lab = UILabel();
    
    
    private  var button: UIButton {
        let button = UIButton.creatButton(imageName: "pencil", title: "进入")
        button.backgroundColor = UIColor.red
        return button
    }
    
    // override 从载方法
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        lab.frame = CGRect(x:0, y:150, width:JkScreenWidth, height:30)

        lab.text = "Swift"
        
        lab.textAlignment = NSTextAlignment(rawValue: 1)!;
        
        view.addSubview(lab)
        
        let btn = button;
        
        
        btn.addTarget(self, action: #selector(testfunc), for: UIControlEvents.touchUpInside);
        
        btn.frame = CGRect(x:0, y:lab.frame.maxY, width:JkScreenWidth, height:30)
        
        self.view.addSubview(btn);
        
        
        
        //延迟执行
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.lab.frame = CGRect(x:0, y:250, width:self.JkScreenWidth, height:30)
                
            }) { (Bool) in
                
            }
            
        }

        let viewsArr = ["1","2","3","4","5","6","7","8","9"];
        
        for (index, i) in viewsArr.enumerated() {
            let a = CGFloat(index / 5);
            let b = CGFloat(index % 5);
            let vieww = getViews(str: [], type: i);
            vieww.frame = CGRect(x:b * (JkScreenWidth) / 5, y:300 + (a * JkScreenWidth / 5), width:JkScreenWidth / 5-1, height:JkScreenWidth / 5-1);
            vieww.tag = Int(i)!;
            vieww.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(testfunc)))
            view.addSubview(vieww);
        }
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
    
    }
    
    func testfunc(sender:UIPanGestureRecognizer, str : String) {
        
        
        print(String(format: "点击方法%d", (sender.view?.tag)!))
        
    }
    
    
    func getViews(str: NSArray, type:String) -> UIView {
        
        let vs = UIView();
        vs.backgroundColor = UIColor.red
        let lab = UILabel()
        lab.frame = vs.frame
        lab.textAlignment = NSTextAlignment(rawValue: 1)!;
        lab.text = type;
        lab.frame = CGRect(x:0, y:0, width:30, height:30);
        vs.addSubview(lab)
        return vs;
        
    }
    
    
    deinit {
        // 返回内部类名
        
//        print("deinit: \(object_getClassName(self))")
//        
//        // 返回应用程序名+类名
//        
//        print("deinit: \(NSStringFromClass(type(of: self)))")
//        
//        // 返回应用程序名+类名+内存地址
//        
//        print("deinit: \(self)")
//        
//        // 返回应用程序名+类名+内存地址
//        
//        print("deinit: \(self.description)")
//        
//        // 返回类名
//        
//        print("deinit: \(type(of: self))")
    }

    
}

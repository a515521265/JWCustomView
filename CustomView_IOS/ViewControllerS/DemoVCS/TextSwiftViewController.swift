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
    
    // override 从载方法
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        lab.frame = CGRect(x:0, y:150, width:JkScreenWidth, height:30)

        lab.text = "Swift"
        
        lab.textAlignment = NSTextAlignment(rawValue: 1)!;
        
        self.view.addSubview(lab)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
    
    }
    
    func testfunc() {
        
        print("点击方法")
        
    }
    
    
}

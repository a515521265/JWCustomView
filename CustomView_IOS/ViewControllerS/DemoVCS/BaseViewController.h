//
//  BaseViewController.h
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JWKitMacro.h"

#import "DemoModel.h"

#import "JWKit.h"

#import "UIViewController+KeyboardCorver.h" //控制器键盘监听

#import "GradientAnimationView.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) DemoModel * baseDemoModel;

@end

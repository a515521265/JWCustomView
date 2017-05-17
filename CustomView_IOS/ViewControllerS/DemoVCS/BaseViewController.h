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

#import "customHUD.h"

#import "NerdyUI.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) DemoModel * baseDemoModel;

/**
 *  全局方法集，直接调用
 *
 */

/* pushAction */
extern void pushViewController(UIViewController *VC,UIViewController *sencondVC);
/* presentAction */
extern void presentViewController(UIViewController *VC,UIViewController *sencondVC);
/* 展示HUD ，无文本*/
extern void showHUD();
/* 展示HUD，带文本 */
extern void showHUDWithString(NSString *string);
/* 展示HUD，只有文本 */
extern void showHUDWithOnlyText(UIViewController *VC, NSString *textStr);
/* 展示成功状态HUD */
extern void showHUDWithSuccessString(NSString *string);
/* 展示失败状态HUD */
extern void showHUDWithErrorString(NSString *string);
/* 展示提示文本HUD，（感叹号） */
extern void showHUDWithInfoString(NSString *string);
/* 展示加载进度HUD，带文本 */
extern void showHUDWithProgressAndString(CGFloat progress, NSString *string);
/* 展示自定义图片HUD，带文本 */
extern void showHUDWithImageAndString(UIImage *image ,NSString *string);
/* 隐藏HUD */
extern void dismissHUD();

extern void dismissHUDWithDelay(NSTimeInterval timeInterval,void(^Block)());


@end

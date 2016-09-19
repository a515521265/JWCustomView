//
//  KeyboardDemoViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "KeyboardDemoViewController.h"

@interface KeyboardDemoViewController ()

@end

@implementation KeyboardDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JWTextField *
    text1 = [[JWTextField alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth,50)];
    text1.placeholder = @"请输入合法的小数金额";
    text1.textAlignment = 0;
    text1.font = [UIFont systemFontOfSize:18];
    text1.importStyle = TextFieldImportStyleRightfulMoney; //设置输入限制的类型
    text1.keyboardType = UIKeyboardTypeDecimalPad;
    text1.importBackString = ^(NSString * money){
        //输入框实时回调内容
        NSLog(@"%@",money);
    };
    [self.view addSubview:text1];
    
    //键盘监听使用
    [self addNotification];
    
}
//清除键盘通知
- (void)dealloc {
    [self clearNotificationAndGesture];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end

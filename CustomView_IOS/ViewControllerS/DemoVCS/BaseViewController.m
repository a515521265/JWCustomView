//
//  BaseViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = self.baseDemoModel.title;
    
    [self.view addSubview:[JWLabel setLabelTitle:self.baseDemoModel.demoDescribe setLabelSize:CGSizeMake(kScreenWidth , 0) setLabelFrameX:(0) setLabelFrameY:64 setLabelColor:[UIColor redColor] setLabelFont:[UIFont systemFontOfSize:20]]];
    
}


@end

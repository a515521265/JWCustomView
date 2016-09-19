//
//  MonitorScreenshotDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/8/30.
//
//

#import "MonitorScreenshotDemoViewController.h"

@interface MonitorScreenshotDemoViewController ()

@end

@implementation MonitorScreenshotDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    JWLabel * lab1 = [[JWLabel alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 50)];
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.text = @"截取当期屏幕";
    [self.view addSubview:lab1];
    
    
}



@end

//
//  CustomSwitchDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/8/30.
//
//

#import "CustomSwitchDemoViewController.h"

#import "ZJSwitch.h"

@interface CustomSwitchDemoViewController ()

@end

@implementation CustomSwitchDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZJSwitch * mySwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(0, 200, 80, 0)];
    mySwitch.tintColor = [UIColor redColor];
    mySwitch.onText = @"ON";
    mySwitch.offText = @"OFF";
    [self.view addSubview:mySwitch];
}


@end

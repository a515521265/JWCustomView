//
//  GradientAnimationDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/7.
//
//

#import "GradientAnimationDemoViewController.h"

@interface GradientAnimationDemoViewController ()

@end

@implementation GradientAnimationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GradientAnimationView * titleView = [[GradientAnimationView alloc]init];
    titleView.frame = CGRectMake(0, kScreenHeight/3, kScreenWidth, 50);
    titleView.backgroundColor = [UIColor clearColor];
    titleView.text = @"恒善信诚科技有限公司";
    [self.view addSubview:titleView];
}

@end

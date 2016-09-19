//
//  CustomProgressDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/8/30.
//
//

#import "CustomProgressDemoViewController.h"

#import "ZFProgressView.h"

@interface CustomProgressDemoViewController ()

@end

@implementation CustomProgressDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView * firstview = self.view.subviews[0];
    
    for (int i = 0 ; i< 9; i++) {
        
        NSInteger a = i / 3;
        NSInteger b = i % 3;
        
        ZFProgressView * progress =  [[ZFProgressView alloc] initWithFrame:CGRectMake(b * kScreenWidth / 3,CGRectGetMaxY(firstview.frame) +(a * kScreenWidth / 3), kScreenWidth / 3, kScreenWidth / 3)];
        [progress setProgressStrokeColor:[self randomColor]];
        [progress setBackgroundStrokeColor:[self randomColor]];
        double c = arc4random_uniform(100);
        [progress setProgress:c/100 Animated:true];
        
        [self.view addSubview:progress];
        
    }
}



-(UIColor *)randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}


@end

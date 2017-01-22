//
//  SpinnerDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 17/1/22.
//
//

#import "SpinnerDemoViewController.h"
#import "SpinnerView.h"

@interface SpinnerDemoViewController ()

@property (nonatomic,strong) SpinnerView * spinner;

@end

@implementation SpinnerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((kScreenWidth-150)/2, kScreenHeight-400, 150, 50);
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"显示下拉列表" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    

    HXWeak_(button)
    HXWeak_self
    [button addSingleTapEvent:^{
        HXStrong_self
        HXStrong_(button)
        if (self.spinner) {
            [self.spinner hiddenView];
            self.spinner = nil;
            return;
        }
        SpinnerView * spinner = [[SpinnerView alloc]initShowSpinnerWithRelevanceView:button];
        spinner.modelArr = @[@"哈哈",@"呵呵",@"嘿嘿",@"嗷嗷",@"啊啊",@"--"].mutableCopy;
        spinner.isNavHeight = true;
        [spinner ShowView];
        spinner.backModel = ^(NSString *backStr){
            [button setTitle:backStr forState:UIControlStateNormal];
            self.spinner = nil;
        };
        self.spinner =spinner;
    }];
}

@end

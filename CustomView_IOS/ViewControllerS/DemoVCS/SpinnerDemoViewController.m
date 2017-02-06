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
    button.frame = CGRectMake((kScreenWidth-150)/2, kScreenHeight-400, 150, 35);
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"显示下拉列表" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    
//    JWAlertView * jwalert1 = [[JWAlertView alloc]initJWAlertViewWithTitle:@"哈哈" message:@"呵呵" delegate:self cancelButtonTitle:@"嘿嘿1" otherButtonTitles:nil];
//    [jwalert1 alertShow];
//    
//    JWAlertView * jwalert2 = [[JWAlertView alloc]initJWAlertViewWithTitle:@"哈哈" message:@"呵呵" delegate:self cancelButtonTitle:@"嘿嘿2" otherButtonTitles:nil];
//    [jwalert2 alertShow];
//
//    JWAlertView * jwalert3 = [[JWAlertView alloc]initJWAlertViewWithTitle:@"哈哈" message:@"呵呵" delegate:self cancelButtonTitle:@"嘿嘿3" otherButtonTitles:nil];
//    [jwalert3 alertShow];
//
//    JWAlertView * jwalert4 = [[JWAlertView alloc]initJWAlertViewWithTitle:@"哈哈" message:@"呵呵" delegate:self cancelButtonTitle:@"嘿嘿4" otherButtonTitles:nil];
//    [jwalert4 alertShow];

    HXWeak_(button)
    [button addSingleTapEvent:^{
        HXStrong_(button)
        SpinnerView * spinner = [[SpinnerView alloc]initShowSpinnerWithRelevanceView:button];
        spinner.modelArr = @[@"哈哈",@"呵呵",@"嘿嘿",@"嗷嗷",@"啊啊",@"--"].mutableCopy;
        spinner.isNavHeight = true;
        spinner.tapDisappear= true;
        [spinner ShowView];
        spinner.backModel = ^(NSString *backStr){
            [button setTitle:backStr forState:UIControlStateNormal];
        };
    }];
}

@end

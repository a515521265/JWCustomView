//
//  SpinnerDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 17/1/22.
//
//

#import "SpinnerDemoViewController.h"
#import "SpinnerView.h"

#import "JWScrollView.h"

#import "MVMaterialButton.h"

#import "MVMaterialView.h"

@interface SpinnerDemoViewController ()<SpinnerViewDelegate>

@property (nonatomic,strong) JWScrollView * scrollView;

@property (nonatomic,strong) SpinnerView * spinner;

@end

@implementation SpinnerDemoViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MVMaterialButton * button = [MVMaterialButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((kScreenWidth-150)/2, kScreenHeight-500, 150, 35);
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"显示下拉列表" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    MVMaterialView * tapView = [[MVMaterialView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), kScreenWidth, 50)];
    tapView.backgroundColor = [UIColor greenColor];
    tapView.tintColor = [UIColor colorWithRed:217/255 green:217/255 blue:217/255 alpha:0.2];
    tapView.colors = @[(id)UIColorFromRGB(0x9164db).CGColor, (id)UIColorFromRGB(0x46bbe3).CGColor];
    [tapView addSingleTapEvent:^{
        NSLog(@"??????");
    }];
    [self.view addSubview:tapView];
    
//    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(button.frame)+300);
    
    
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
//        spinner.delegate =self;
        [spinner ShowView];
        spinner.backModel = ^(NSString *backStr){
            [button setTitle:backStr forState:UIControlStateNormal];
        };
    }];
    
}

//-(CGFloat)spinnerItemHeight{
//    return 80;
//}

@end

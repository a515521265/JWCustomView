//
//  ForgiveViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/24.
//
//

#import "ForgiveViewController.h"

@interface ForgiveViewController ()
@property (nonatomic,strong) JWScrollView * scrollView;
@end

@implementation ForgiveViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * view = [self.view.subviews firstObject];
    view.hidden = true;
    
    static NSInteger integer = 6;
    
    NSMutableArray * viewArr = @[].mutableCopy;
    
    for (int i = 0 ; i< 132; i++) {
        
        NSInteger a = i / integer;
        NSInteger b = i % integer;
        UISwitch * sswitch = [[UISwitch alloc]initWithFrame:CGRectMake(5+b * kScreenWidth / 6,5+(a * 35), kScreenWidth / 6, 30)];
        [self.scrollView addSubview:sswitch];
        [viewArr addObject:sswitch];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i= 0; i<viewArr.count; i++) {
                [NSThread sleepForTimeInterval:0.1];
                UISwitch * sswitch = viewArr[i];
                dispatch_async(dispatch_get_main_queue(), ^{
                    sswitch.on = true;
                });
            }
        });
    });
    
    
    UIView * boomView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.scrollView.subviews.lastObject.frame), kScreenWidth+50, 50)];
    boomView.bgColor([UIColor redColor]);
    [self.scrollView addSubview:boomView];
    
    

    

    
    
    
}

@end

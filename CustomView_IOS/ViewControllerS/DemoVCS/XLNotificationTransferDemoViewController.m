//
//  XLNotificationTransferDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/10.
//
//

#import "XLNotificationTransferDemoViewController.h"
#import "XLNotificationTransfer.h"
#import "JWScrollView.h"
#import "UIImage+ColorImage.h"
#import "SpecsModel.h"
#import "TooltipView.h"

@interface XLNotificationTransferDemoViewController ()

@end

@implementation XLNotificationTransferDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义通知key
    [@"tongzhi" addObserver_callback:^(id obj) {
        NSLog(@"-- %@",obj);
    }];
    
    //系统通知key
    [UIKeyboardWillShowNotification addObserver_callback:^(NSNotification *obj) {
        NSLog(@"----showkeyboard");
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [@"tongzhi" postNotification_userInfo:@"haha"];
}


- (void)dealloc {
    [@"tongzhi" removeObserver];
    
    [UIKeyboardWillShowNotification removeObserver];
}


@end

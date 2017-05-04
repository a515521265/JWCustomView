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

- (void)dealloc {
    
    NSLog(@"dealloc------%@",NSStringFromClass(self.class));
    
}



extern void pushViewController(UIViewController *VC,UIViewController *sencondVC){
    [VC.navigationController pushViewController:sencondVC animated:YES];
}
extern void presentViewController(UIViewController *VC,UIViewController *sencondVC){
    [VC presentViewController:sencondVC animated:YES completion:nil];
}
extern void showHUD(){
//    [SVProgressHUD show];
}
extern void showHUDWithString(NSString *string){
//    [SVProgressHUD showWithStatus:string];
}

extern void showHUDWithSuccessString(NSString *string){
//    [SVProgressHUD showSuccessWithStatus:string];
}

extern void showHUDWithErrorString(NSString *string){
//    [SVProgressHUD showErrorWithStatus:string];
}

extern void showHUDWithInfoString(NSString *string){
//    [SVProgressHUD showInfoWithStatus:string];
}

extern void showHUDWithProgressAndString(CGFloat progress, NSString *string){
//    [SVProgressHUD showProgress:progress status:string];
}

extern void showHUDWithImageAndString(UIImage *image ,NSString *string){
//    [SVProgressHUD showImage:image status:string];
}

extern void dismissHUD(){
//    [SVProgressHUD dismiss];
}

extern void dismissHUDWithDelay(NSTimeInterval timeInterval,void(^Block)()){
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
        Block();
        
    });
}

extern void showHUDWithOnlyText(UIViewController *VC, NSString *textStr){
//    [VC.view makeToast:textStr];
}




@end

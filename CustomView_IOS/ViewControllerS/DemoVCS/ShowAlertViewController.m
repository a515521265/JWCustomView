//
//  ShowAlertViewController.m
//  OverseasVersion
//
//  Created by 恒善信诚科技有限公司 on 17/3/6.
//  Copyright © 2017年 梁家文. All rights reserved.
//

#import "ShowAlertViewController.h"


@interface ShowAlertViewController ()

@property (nonatomic,strong) UIImageView * picalogoImage;

@end

@implementation ShowAlertViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    HXWeak_self
    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
//    self.view = effectview;
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];

    
    CGRect  rect = self.view.getRelativewindowFrame(self.showImageView);
    
    
    UIImageView * picalogoImage = [[UIImageView alloc]initWithFrame:rect];
    
    picalogoImage.image = self.showImageView.image;
    
    [picalogoImage addSingleTapEvent:^{
        HXStrong_self
        [self didmissVC];
    }];
    [self.view addSubview:picalogoImage];
    self.picalogoImage = picalogoImage;
    
    [self.view addSingleTapEvent:^{
        HXStrong_self
        [self didmissVC];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            picalogoImage.frame = CGRectMake((kScreenWidth - self.showImageView.image.size.width)/2,(kScreenHeight - self.showImageView.image.size.height)/2, self.showImageView.image.size.width, self.showImageView.image.size.height);
            self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            
        } completion:^(BOOL finished) {
            
        }];
        
    });

    
}


-(void)didmissVC{

    CGRect  rect = self.view.getRelativewindowFrame(self.showImageView);
    [UIView animateWithDuration:0.5 animations:^{
        self.picalogoImage.frame = rect;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    } completion:^(BOOL finished) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}


@end

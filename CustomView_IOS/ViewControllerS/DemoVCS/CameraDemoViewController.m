//
//  CameraDemoViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "CameraDemoViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "JPSImagePickerController.h"

@interface CameraDemoViewController ()<JPSImagePickerDelegate>

@property (strong, nonatomic) JPSImagePickerController *imagePickerController;

@end

@implementation CameraDemoViewController

#pragma mark - JPSImagePickerController
-(JPSImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [JPSImagePickerController new];
        _imagePickerController.delegate = self;
        _imagePickerController.flashlightEnabled = NO;
    }
    return _imagePickerController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, kScreenHeight/2,kScreenWidth , 30);
    [button addTarget:self action:@selector(showcamera) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"显示第三方相机" forState:0];
    [self.view addSubview:button];
    
    NSInteger lineNumber = 20;
    
    for (int i = 0; i<lineNumber; i++) {
        [self.view addSubview:[JWLabel addLineLabel:CGRectMake(kScreenWidth/lineNumber*i, 0, 0.5, kScreenHeight)]];
        [self.view addSubview:[JWLabel addLineLabel:CGRectMake(0, kScreenHeight/lineNumber*i, kScreenWidth, 0.5)]];
    }
    
    
    
}

-(void)showcamera{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        JWAlertView * alertView  = [[JWAlertView alloc]initJWAlertViewWithTitle:@"温馨提示" message:@"当前相机不可使用，是否开启权限" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alertView alertShow];
        return;
    }
    [self presentViewController:self.imagePickerController animated: YES completion:nil];
}


#pragma mark  JPSImagePickerControllerDelegate
- (void)picker:(JPSImagePickerController *)picker didTakePicture:(UIImage *)picture {
    //拍摄中
    picker.confirmationString = @"提示";
    picker.confirmationOverlayString = @"Analyzing Image...";
    picker.confirmationOverlayBackgroundColor = [UIColor orangeColor];
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        picker.confirmationOverlayString = @"Good Quality";
        picker.confirmationOverlayBackgroundColor = [UIColor colorWithRed:0 green:0.8f blue:0 alpha:1.0f];
    });
}

- (void)picker:(JPSImagePickerController *)picker didConfirmPicture:(UIImage *)picture {
    //获取到拍摄的图片 picture
}

- (void)pickerDidCancel:(JPSImagePickerController *)picker {
    //取消执行
    self.imagePickerController = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

//
//  AppDelegate.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoListViewController.h"
#import "FPSLabelManager.h"
#import "FPSShowLabel.h"

#import "UIView+TYLaunchAnimation.h"
#import "TYLaunchFadeScaleAnimation.h"
#import "UIImage+TYLaunchImage.h"
#import "TAdLaunchImageView.h"
//uidebug
#import "MMPlaceHolder.h"
//接口debug
#import "JxbDebugTool.h"

#import "KTouchPointerWindow.h"
#import "NSObject+Extension.h"

@interface AppDelegate ()
@property (nonatomic,strong) FPSLabelManager * showFPSLabel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //using it for size debug
//    [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor blackColor];
//    [MMPlaceHolderConfig defaultConfig].lineWidth = 0.5;
//    [MMPlaceHolderConfig defaultConfig].arrowSize = 5;
//    [MMPlaceHolderConfig defaultConfig].backColor = [UIColor clearColor];
//    [MMPlaceHolderConfig defaultConfig].frameWidth = 0;
//    [MMPlaceHolderConfig defaultConfig].visibleKindOfClasses = @[UIImageView.class,UILabel.class];
//    
//    //using it for frame debug
//    [MMPlaceHolderConfig defaultConfig].autoDisplay = YES;
//    [MMPlaceHolderConfig defaultConfig].autoDisplaySystemView = YES;
//    [MMPlaceHolderConfig defaultConfig].showArrow = YES;
//    [MMPlaceHolderConfig defaultConfig].showText = YES;
//    
//    //using it to control global visible
//    [MMPlaceHolderConfig defaultConfig].visible = NO;
    
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[DemoListViewController new]];
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
//    
//    [[JxbDebugTool shareInstance] setMainColor:[UIColor redColor]];
//    [[JxbDebugTool shareInstance] enableDebugMode];
//    
    
    //fpslab
    FPSLabelManager * fpsL = [FPSLabelManager new];
    self.showFPSLabel = fpsL;
    
//    // Ad(广告) FadeAnimation
//    TAdLaunchImageView *adLaunchImageView = [[TAdLaunchImageView alloc]initWithImage:[UIImage ty_getLaunchImage]];
//    adLaunchImageView.URLString = @"http://img1.126.net/channel6/2015/020002/2.jpg?dpi=6401136";
//    
//    // 显示imageView
//    [adLaunchImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeAnimationWithDelay:5.0] completion:^(BOOL finished) {
//        
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        NSLog(@"finished");
//    }];
//    
//    __typeof (self) __weak weakSelf = self;
//    // 点击广告block
//    [adLaunchImageView setClickedImageURLHandle:^(NSString *URLString) {
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
////        [weakSelf pushAdViewCntroller];
//        NSLog(@"clickedImageURLHandle");
//    }];
    
    // FadeScaleAnimation
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage ty_getLaunchImage]];
    [imageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeScaleAnimation] completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        NSLog(@"finished");
    }];
    
//    [self systemUIDebug];
    
//    KTouchPointerWindowInstall();
    
    return YES;

}

-(void)systemUIDebug{

    id debugClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [debugClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
    });
    
    id debugOverlayInstance = [debugClass performSelector:NSSelectorFromString(@"overlay")];
    [debugOverlayInstance performSelector:NSSelectorFromString(@"toggleVisibility")];

}

//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
    //添加显示
    UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image_];
    imgvPhoto.frame = CGRectMake(self.window.frame.size.width/2, self.window.frame.size.height/2, self.window.frame.size.width/2, self.window.frame.size.height/2);
    
    //添加边框
    CALayer * layer = [imgvPhoto layer];
    layer.borderColor = [
                         [UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    //添加四个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(0, 0);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 10.0;
    //添加两个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 2.0;
    
    [self.window addSubview:imgvPhoto];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imgvPhoto removeFromSuperview];
    });
}
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    
    return [UIImage imageWithData:imageData];
    
}


//强制使用系统键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier {
    
    if ([extensionPointIdentifier isEqualToString:@"返回默认键盘"]) {
        return true;
    }else{
        return false;
    }
}

//不活跃
- (void)applicationWillResignActive:(UIApplication *)application{

     [self application:[UIApplication sharedApplication] shouldAllowExtensionPointIdentifier:@"返回默认键盘"];
    
}

- (void)applicationWillTerminate:(UIApplication *)application{
    [self application:[UIApplication sharedApplication] shouldAllowExtensionPointIdentifier:@"返回默认键盘"];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    NSString *urll = url.absoluteString;
    NSString *scheme = @"hsxc://";
    if ([urll hasPrefix:scheme]) {
//        [self getURLParameters:urll];
        NSLog(@"%@",[self getURLParameters:urll]);
        
        return NO;
    }
    return YES;
    
//    hsxc://platformapi/startapp?saId=10000007&qrcode=HTTPS://QR.ALIPAY.COM/FKX05817EWSX8XRYV7SW28
}
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}
@end

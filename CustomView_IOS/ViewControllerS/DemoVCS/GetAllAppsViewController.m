//
//  GetAllAppsViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/18.
//
//

#import "GetAllAppsViewController.h"
#import "LMAppController.h"
#import "UIImage+ColorImage.h"
#import "JWScrollView.h"
#import "ShowAlertViewController.h"

@interface GetAllAppsViewController ()

@property (nonatomic,strong) JWScrollView * scrollView;

@end

@implementation GetAllAppsViewController

-(JWScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray<LMApp *>* apps = [LMAppController sharedInstance].installedApplications;
    // pre-render the known icons
    NSMutableArray* images = [NSMutableArray array];
    //圆角
//    UIBezierPath* clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(0, 0, 60, 60), 0.5,0.5)];
    for(LMApp* app in apps)
    {
        UIImage* image = app.icon;
        
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(60, 60), NO, [UIScreen mainScreen].scale);
//        [clipPath addClip];
//        [image drawInRect:CGRectMake(0, 0, 60, 60)];
//        UIImage* renderedImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
        [images addObject:image];
    }
    
    
    for (int i = 0 ; i < apps.count; i++){
        UIButton *button = [self CreateBtnWithTitle:apps[i].name image:images[i]];
        button.tag = 1001+i;
        NSInteger a = i / 3;
        NSInteger b = i % 3;
        button.x = b * kScreenWidth / 3;
        button.y = (a * kScreenWidth / 3);
        [button addSingleTapEvent:^{
            [[LMAppController sharedInstance]openAppWithBundleIdentifier:apps[i].bundleIdentifier];
        }];
        [self.scrollView addSubview:button];
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(button.frame)+64);
    }

    


    [CABasicAnimation animationWithKeyPath:@""];
}

-(UIButton *)CreateBtnWithTitle:(NSString *)title image:(UIImage *)image{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitleColor:UIColorFromRGB(0x656364) forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xffffff)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf4f4f4)] forState:UIControlStateHighlighted];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = UIColorFromRGB(0xefeaea).CGColor;
//    [button addTarget:self action:@selector(buttonitem:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake( 0, 0, kScreenWidth / 3, kScreenWidth / 3);
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.width/2-25, 20, 50, 50)];
//    imageView.image = [UIImage imageNamed:imageStr];
    imageView.image = image;
    [button addSubview:imageView];
    HXWeak_self
    [button addlongTapEvent:^{
        HXStrong_self
        ShowAlertViewController * aletrVC = [[ShowAlertViewController alloc] init];
        aletrVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        aletrVC.modalPresentationStyle = UIModalPresentationCustom;
        aletrVC.showImageView = imageView;
        [self presentViewController:aletrVC animated:YES completion:nil];
    }];

    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), button.width, 40)];
    titleLab.text = title;
    titleLab.textAlignment = 1;
    titleLab.textColor = UIColorFromRGB(0x535353);
    titleLab.font = [UIFont systemFontOfSize:13];
    [button addSubview:titleLab];
    return button;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

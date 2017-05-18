//
//  SuspensionViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/18.
//
//

#import "SuspensionViewController.h"

#import "YYWeakProxy.h"

@interface SuspensionViewController ()

@property (nonatomic,strong) YYAnimatedImageView * imagev;
@property (nonatomic,strong) YYAnimatedImageView * imagev2;

@end

@implementation SuspensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * view = [self.view.subviews firstObject];
    view.hidden = true;
    
    
    YYAnimatedImageView * imagev = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(20, 120, 90, 90)];
    YYImage* image = [YYImage imageNamed:@"load4.gif"];
    imagev.image = image;
    [self.view addSubview:imagev];
    self.imagev = imagev;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(change) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    self.imagev2 = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight-90, 118, 90)];
    YYImage* image2 = [YYImage imageNamed:@"load5.gif"];
    self.imagev2.image = image2;
    [self.view addSubview:self.imagev2];
    
    
    NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(change2) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSRunLoopCommonModes];


    
//    YYAnimatedImageView * imagev3 = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kScreenWidth, kScreenWidth, kScreenWidth)];
//    YYImage* image3 = [YYImage imageNamed:@"load10.gif"];
//    imagev3.image = image3;
//    [self.view addSubview:imagev3];
    
    
    YYAnimatedImageView * imagev4 = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight-68-68-68, 68, 68)];
    YYImage * image4 = [YYImage imageNamed:@"load2.gif"];
    imagev4.image = image4;
    [self.view addSubview:imagev4];
    
}


-(void)change2{
    
    if (self.imagev2.x>=kScreenWidth+118) {
        self.imagev2.x = -118;
    }

    [UIView animateWithDuration:0.6 animations:^{

        self.imagev2.x = self.imagev2.x + 20;

    } completion:^(BOOL finished) {
        
    }];

    
}

-(void)change{

    
    static BOOL up;
    
    up = !up;
    
    [UIView animateWithDuration:0.5 animations:^{
        if (up) {
            self.imagev.y = self.imagev.y + 10;
        }else{
            self.imagev.y = self.imagev.y - 10;
        }
    } completion:^(BOOL finished) {
        
    }];
    
    
    
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

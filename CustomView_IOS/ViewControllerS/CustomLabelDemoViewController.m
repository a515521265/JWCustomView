//
//  CustomLabelDemoViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "CustomLabelDemoViewController.h"

#import "YYWeakProxy.h"

@interface CustomLabelDemoViewController ()

@property (nonatomic,strong) JWLabel * label2;

@end

@implementation CustomLabelDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //富文本lab
    JWLabel * label1 = [[JWLabel alloc]initWithFrame:CGRectMake(0, kScreenHeight/2, kScreenWidth, 50)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.labelAnotherFont = [UIFont systemFontOfSize:18];//设置富文本字体大小
    label1.textColor =[UIColor blackColor];
    label1.labelAnotherColor = [UIColor redColor];//设置富文本文字颜色
    label1.text = [NSString stringWithFormat:@"公司名称:[%@][<%@>]",@"百度",@"科技有限公司"];
    [self.view addSubview:label1];
    //数字动画效果lab
    JWLabel * label2 = [[JWLabel alloc]initWithFrame:CGRectMake(0, kScreenHeight/2+50, kScreenWidth, 50)];
    label2.text = @"100.00";
    label2.textColor = [UIColor orangeColor];
    self.label2 = label2;
    [self.view addSubview:label2];
    
    //*使用YYWeakProxy避免内存泄漏！*
    /*
     时钟类都是由主运行循环进行强引用的，而时钟会强引用target，所以造成了内存泄漏
     YY是让时钟强引用一个弱指针，所以当target为nil的时候，时钟就会停止
     第二种方法是手动注销时钟
     */
    [[NSTimer scheduledTimerWithTimeInterval:2 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(starTime) userInfo:nil repeats:YES] fire];
    
    //kvo监听内容改变
    [self.label2 xw_addObserverBlockForKeyPath:@"text" block:^(id obj, id oldVal, id newVal) {
        NSLog(@"kvo，修改self.label2.text为%@", newVal);
    }];
    
}

-(void)starTime{
    [self.label2 setNumberAnimationForValueContent:arc4random_uniform(9999999)];
}




@end

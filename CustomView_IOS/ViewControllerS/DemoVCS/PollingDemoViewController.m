//
//  PollingDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/7.
//
//

#import "PollingDemoViewController.h"
#import "HomePublicView.h"
#import "bannerData.h"
@interface PollingDemoViewController ()

@end

@implementation PollingDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片轮播
    HomePublicView * adView =[[HomePublicView alloc]initWithHomeAdViewFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/3)];
    adView.imageList = @[@"http://img.ui.cn/data/file/0/6/9/40960.gif?imageMogr2/auto-orient/strip/thumbnail/!900%3E",@"http://img.ui.cn/data/file/1/0/4/103401.gif?imageMogr2/auto-orient/strip/thumbnail/!900%3E",@"http://img.ui.cn/data/file/3/8/3/652383.gif?imageMogr2/auto-orient/strip/thumbnail/!900%3E"];
    adView.TapADindex = ^(NSInteger index){
        NSLog(@"广告索引：%ld",(long)index);
    };
    [self.view addSubview:adView];
    //model
    bannerData *model1 = [[bannerData alloc]init];
    model1.title = @"松鼠松鼠松鼠";
    bannerData *model2 = [[bannerData alloc]init];
    model2.title = @"金融金融金融";
    NSMutableArray * messageList = [NSMutableArray arrayWithObjects:model1,model2, nil];
    //消息轮播
    HomePublicView * headLine = [[HomePublicView alloc]initWithHomeHeadlineViewFrame:CGRectMake(0, CGRectGetMaxY(adView.frame), kScreenWidth, 40)];
    headLine.headlineList = messageList;
    headLine.TapHeadlineindex = ^ (NSInteger index){
        NSLog(@"消息索引：%ld",(long)index);
    };
    [self.view addSubview:headLine];
}


@end

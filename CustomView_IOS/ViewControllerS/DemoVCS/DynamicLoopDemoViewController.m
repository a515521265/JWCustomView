//
//  DynamicLoopDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/7.
//
//

#import "DynamicLoopDemoViewController.h"
#import "DynamicLoop.h"
@interface DynamicLoopDemoViewController ()

@end

@implementation DynamicLoopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DynamicLoop * dynamicLoop = [[DynamicLoop alloc]init];
    dynamicLoop.frame = CGRectMake(0, 10, kScreenWidth, kScreenWidth);
    dynamicLoop.backgroundColor = [UIColor clearColor];
    dynamicLoop.value = 0.6;
    dynamicLoop.color = [UIColor orangeColor];
    [[dynamicLoop layer] setShadowOffset:CGSizeMake(1, 3)]; // 阴影的范围
    [[dynamicLoop layer] setShadowRadius:5]; // 阴影扩散的范围控制
    [[dynamicLoop layer] setShadowOpacity:1]; // 阴影透明度
    [[dynamicLoop layer] setShadowColor:[UIColor grayColor].CGColor]; // 阴影的颜色
    [self.view addSubview:dynamicLoop];

    self.view.backgroundColor = [UIColor orangeColor];
    
}


@end

//
//  XYPieChartDemoViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "XYPieChartDemoViewController.h"

#import "XYPieChart.h"

@interface XYPieChartDemoViewController () <XYPieChartDelegate, XYPieChartDataSource>

@property (strong, nonatomic) XYPieChart * PiechartView;/**< 饼状图 */

@property (nonatomic, strong) NSMutableArray *slicesdata;/**< 饼状图数据 */

@property (nonatomic, strong) NSArray *sliceColors;/**< 饼状图对应颜色数据 */

@end

@implementation XYPieChartDemoViewController

-(NSArray *)sliceColors{

    if (!_sliceColors) {
        _sliceColors = @[UIColorFromRGB(0xf37328),
                         UIColorFromRGB(0x69c3fe),
                         UIColorFromRGB(0x95cf1d),
                         UIColorFromRGB(0xf54da5)];
    }
    return _sliceColors;
}

-(NSMutableArray *)slicesdata{
    if (!_slicesdata) {
        _slicesdata = [NSMutableArray arrayWithArray:@[@11,@12,@13,@14]];
    }
    return _slicesdata;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PiechartView = [[XYPieChart alloc]initWithFrame:CGRectMake(0, kScreenHeight/2-kScreenWidth/2, kScreenWidth, kScreenWidth) Center:CGPointMake(kScreenWidth/2, kScreenHeight/5) Radius:kScreenWidth/4];
    [self.view addSubview:self.PiechartView];
    [self.PiechartView setDataSource:self];
    [self.PiechartView setStartPieAngle:M_PI_2];
    [self.PiechartView setAnimationSpeed:0.5];
    [self.PiechartView setLabelRadius:160];
    [self.PiechartView setShowPercentage:YES];
    [self.PiechartView setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.PiechartView setUserInteractionEnabled:NO];
    [self.PiechartView setLabelShadowColor:[UIColor blackColor]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.PiechartView reloadData];
    });
}

#pragma mark - XYPieChart delegate
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart{
    return self.slicesdata.count;
}
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    return [[self.slicesdata objectAtIndex:index] intValue];
}
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

@end

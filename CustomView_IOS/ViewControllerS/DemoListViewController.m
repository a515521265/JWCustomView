//
//  DemoListViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//



#import "DemoListViewController.h"

#import "JWKitMacro.h" //宏定义类

#import "DemoModel.h"  //模型

#import "BaseViewController.h"

@interface DemoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray <DemoModel *> * demoList;

@end

@implementation DemoListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"项目集合";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.showsVerticalScrollIndicator = FALSE;
    _tableView.showsHorizontalScrollIndicator = FALSE;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.delaysContentTouches = false;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    self.demoList = @[
                      [DemoModel itemWithDcit:@{@"title":@"PDTSimpleCalendar",@"demoDescribe":@"仿系统的第三方日历选择控件",@"className":@"PDTSimpleCalendarViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"JPSImagePickerController",@"demoDescribe":@"仿系统的第三方相机控件",@"className":@"CameraDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"KeyboardDemoViewController",@"demoDescribe":@"不会遮挡输入框的键盘&自定义textfield",@"className":@"KeyboardDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"CustomLabelDemoViewController",@"demoDescribe":@"自定义富文本label&kvo监听属性变化,block回调",@"className":@"CustomLabelDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"WebViewDemoViewController",@"demoDescribe":@"webview和js交互的封装",@"className":@"WebViewDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"XYPieChartDemoViewController",@"demoDescribe":@"第三方的饼状图",@"className":@"XYPieChartDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"SearchBankDemoViewController",@"demoDescribe":@"检索银行demo",@"className":@"SearchBankDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"CustomProgressDemoViewController",@"demoDescribe":@"自定义进度圈",@"className":@"CustomProgressDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"LocalCheckBankDemoViewController",@"demoDescribe":@"本地校验银行卡",@"className":@"LocalCheckBankDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"SavePermanentDemoViewController",@"demoDescribe":@"永久保存数据到到手机",@"className":@"SavePermanentDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"CustomSwitchDemoViewController",@"demoDescribe":@"可设置文字和颜色的Switch",@"className":@"CustomSwitchDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"MonitorScreenshotDemoViewController",@"demoDescribe":@"监听用户的截屏行为",@"className":@"MonitorScreenshotDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"GradientAnimationDemoViewController",@"demoDescribe":@"渐变色动画label",@"className":@"GradientAnimationDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"DynamicLoopDemoViewController",@"demoDescribe":@"水波纹动画",@"className":@"DynamicLoopDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"PollingDemoViewController",@"demoDescribe":@"广告轮播封装",@"className":@"PollingDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"LineLayoutDemoViewController",@"demoDescribe":@"纵向线性布局的实现",@"className":@"LineLayoutDemoViewController"}]
                      ];
    
    
}

#pragma mark - 设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.demoList[indexPath.row].demoDescribe;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BaseViewController * viewController = [NSClassFromString(self.demoList[indexPath.row].className) new];
    viewController.hidesBottomBarWhenPushed=true;
    if (indexPath.row) {
        viewController.baseDemoModel = self.demoList[indexPath.row];
    }
    [self.navigationController pushViewController:viewController  animated:true];
    
}

#pragma mark - 设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.demoList.count;
}

@end

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

#import <SystemConfiguration/CaptiveNetwork.h>
#import <arpa/inet.h>
#import <netinet/in.h>
#import <ifaddrs.h>

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
                      [DemoModel itemWithDcit:@{@"title":@"LineLayoutDemoViewController",@"demoDescribe":@"纵向线性布局的实现",@"className":@"LineLayoutDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"JSPatchDemoViewController",@"demoDescribe":@"JSPatchDemo用js动态添加控件",@"className":@"JSPatchDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"HTMLDemoViewController",@"demoDescribe":@"测试html文件",@"className":@"HTMLDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"WKWebViewDemoViewController",@"demoDescribe":@"wkwebviewDemo",@"className":@"WKWebViewDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"JWTextViewDemoViewController",@"demoDescribe":@"TextViewDemo",@"className":@"JWTextViewDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"XLNotificationTransferDemoViewController",@"demoDescribe":@"通知封装",@"className":@"XLNotificationTransferDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"ZLYViewController",@"demoDescribe":@"水波纹效果封装",@"className":@"ZLYViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"LoadingDemoViewController",@"demoDescribe":@"加载提示",@"className":@"LoadingDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"LoadingDemoViewController",@"demoDescribe":@"沙画效果",@"className":@"SandDrawDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"SpinnerDemoViewController",@"demoDescribe":@"下拉菜单封装",@"className":@"SpinnerDemoViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"TextTabViewController",@"demoDescribe":@"测试tabview",@"className":@"TextTabViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"QQTextViewController",@"demoDescribe":@"测试QQtabview",@"className":@"QQTextViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"TabViewLayoutTextViewController",@"demoDescribe":@"测试tabview实现图片排版",@"className":@"TabViewLayoutTextViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"LoadGIFimageViewVC",@"demoDescribe":@"加载gif图片",@"className":@"LoadGIFimageViewVC"}],
                      [DemoModel itemWithDcit:@{@"title":@"SuspensionViewController",@"demoDescribe":@"悬浮",@"className":@"SuspensionViewController"}],
                      [DemoModel itemWithDcit:@{@"title":@"GetAllAppsViewController",@"demoDescribe":@"获取全部app列表",@"className":@"GetAllAppsViewController"}]
                      ];
    

    
    
    
    
    
    
    
    
    
//    [self setStatusBarBackgroundColor:[UIColor blueColor]];
 
    NSLog(@"wifi信息---%@\n%@",[self fetchSSIDInfo],[self getLocalInfoForCurrentWiFi]);
    
//    showHUD();
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dismissHUD();
//    });
    
    
    
    
}




//获取WiFi 信息，返回的字典中包含了WiFi的名称、路由器的Mac地址、还有一个Data(转换成字符串打印出来是wifi名称)
- (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}
//获取广播地址、子网掩码、端口
- (NSMutableDictionary *)getLocalInfoForCurrentWiFi {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        //*/
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    //----192.168.1.255 广播地址
                    NSString *broadcast = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    if (broadcast) {
                        [dict setObject:broadcast forKey:@"broadcast"];
                    }
                    NSLog(@"broadcast address--%@",broadcast);
                    //--192.168.1.106 本机地址
                    NSString *localIp = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    if (localIp) {
                        [dict setObject:localIp forKey:@"localIp"];
                    }
                    NSLog(@"local device ip--%@",localIp);
                    //--255.255.255.0 子网掩码地址
                    NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    if (netmask) {
                        [dict setObject:netmask forKey:@"netmask"];
                    }
                    NSLog(@"netmask--%@",netmask);
                    //--en0 端口地址
                    NSString *interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    if (interface) {
                        [dict setObject:interface forKey:@"interface"];
                    }
                    NSLog(@"interface--%@",interface);
                    return dict;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return dict;
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
    
    
    //modal透明界面
//    UIViewController *vc = [[UIViewController alloc] init];
//    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//    {
//        na.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    }
//    else
//    {
//        self.modalPresentationStyle=UIModalPresentationCurrentContext;
//    }
//    
//    [self presentViewController:na animated:YES completion:nil];
    
    
}


- (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
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

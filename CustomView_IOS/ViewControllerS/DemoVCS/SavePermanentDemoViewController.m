//
//  SavePermanentDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/8/30.
//
//

#import "SavePermanentDemoViewController.h"
#import "KeychainIDFA.h"
#import "KeychainHelper.h"

@interface SavePermanentDemoViewController ()

@end

@implementation SavePermanentDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //存储数据
    [KeychainHelper save:dataL data:@"恒善信诚"];
    //加载数据
    NSString * str =[KeychainHelper load:dataL];
    NSLog(@"---%@",str);
    
}

@end

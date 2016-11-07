//
//  JWTextViewDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/7.
//
//

#import "JWTextViewDemoViewController.h"
#import "JWTextView.h"

@interface JWTextViewDemoViewController ()

@end

@implementation JWTextViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    JWTextView * textView = [[JWTextView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, 30)];
    textView.backgroundColor = [UIColor redColor];
    textView.importStyle = TextViewImportStyleRightfulMoney;
    textView.maxlength = 100;
    textView.importBackString = ^(NSString * backStr){
        NSLog(@"回调----%@",backStr);
    };
    [self.view addSubview:textView];
    
}


@end

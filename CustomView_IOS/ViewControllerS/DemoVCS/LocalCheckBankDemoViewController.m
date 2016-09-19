//
//  LocalCheckBankDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/8/30.
//
//

#import "LocalCheckBankDemoViewController.h"

#import "DWBankModel.h"

@interface LocalCheckBankDemoViewController ()

@property (nonatomic,strong) JWLabel * bankNameLab;

@end

@implementation LocalCheckBankDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    UIView * firstV = [self.view.subviews firstObject];
    
    JWTextField *
    text1 = [[JWTextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstV.frame)+10, kScreenWidth,50)];
    text1.placeholder = @"请输入银行卡号";
    text1.textAlignment = 0;
    text1.font = [UIFont systemFontOfSize:18];
    text1.importStyle = TextFieldImportStyleNumber; //设置输入限制的类型
    text1.maxLength = 22; //最大输入位数限制
    text1.keyboardType = UIKeyboardTypeNumberPad;
    text1.importBackString = ^(NSString * money){
        if (money.length < 5) {
            self.bankNameLab.text = @"";
        }
        if (money.length == 8) {
            self.bankNameLab.text = [DWBankModel backbankenameWithBanknumber:money];
        }
    };
    [self.view addSubview:text1];
    
    self.bankNameLab = [[JWLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(text1.frame), kScreenWidth, 50)];
    self.bankNameLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.bankNameLab];
    
    
}


//清除键盘通知
- (void)dealloc {
    [self clearNotificationAndGesture];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end

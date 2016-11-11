//
//  XLNotificationTransferDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/10.
//
//

#import "XLNotificationTransferDemoViewController.h"
#import "XLNotificationTransfer.h"
#import "JWScrollView.h"
#import "UIImage+ColorImage.h"
#import "SpecsModel.h"
#import "TooltipView.h"

@interface XLNotificationTransferDemoViewController ()

@property (nonatomic,strong) JWScrollView * scrollView;

@property (nonatomic,strong) NSMutableArray <LayoutModel *>* modelArr;

@end

@implementation XLNotificationTransferDemoViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
//        _scrollView.delaysContentTouches =false;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义通知key
    [@"tongzhi" addObserver_callback:^(id obj) {
        NSLog(@"-- %@",obj);
    }];
    
    //系统通知key
    [UIKeyboardWillShowNotification addObserver_callback:^(NSNotification *obj) {
        NSLog(@"----showkeyboard");
    }];
    
    self.modelArr = [NSMutableArray arrayWithCapacity:10];
    
    for (int i =  0; i< 13; i++) {
        LayoutModel * model  = [LayoutModel new];
        model.title = @"包包";
        model.pid = i+1;
        model.image = [NSString stringWithFormat:@"common-hud%d",i+1];
        [self.modelArr addObject:model];
    }
    
    for (int i = 0 ; i < self.modelArr.count; i++){
        UIButton *button = [self CreateBtnWithTitle:self.modelArr[i].title imageStr:self.modelArr[i].image];
        button.tag = 1001+i;
        NSInteger a = i / 3;
        NSInteger b = i % 3;
        button.x = b * kScreenWidth / 3;
        button.y = (a * kScreenWidth / 3) +64;
        [self.scrollView addSubview:button];
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(button.frame)+10);
    }
    
}

-(UIButton *)CreateBtnWithTitle:(NSString *)title imageStr:(NSString *)imageStr{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitleColor:UIColorFromRGB(0x656364) forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xffffff)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf4f4f4)] forState:UIControlStateHighlighted];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = UIColorFromRGB(0xefeaea).CGColor;
    [button addTarget:self action:@selector(buttonitem:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake( 0, 0, kScreenWidth / 3, kScreenWidth / 3);
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.width/2-25, 20, 50, 50)];
    imageView.image = [UIImage imageNamed:imageStr];
    [button addSubview:imageView];
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), button.width, 40)];
    titleLab.text = title;
    titleLab.textAlignment = 1;
    titleLab.textColor = UIColorFromRGB(0x535353);
    titleLab.font = [UIFont systemFontOfSize:13];
    [button addSubview:titleLab];
    return button;
}

-(void)buttonitem:(UIButton *)btn{
    
    Class availableClass = NSClassFromString(self.modelArr[btn.tag - 1001].clasStr);
    if (availableClass) {
        BaseViewController * viewController = [NSClassFromString(self.modelArr[btn.tag - 1001].clasStr) new];
        [self.navigationController pushViewController:viewController animated:true];
    }else{
    #ifdef DEBUG
            [TooltipView showWithText:self.modelArr[btn.tag - 1001].clasStr];
    #else
    #endif
    }

    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [@"tongzhi" postNotification_userInfo:@"haha"];
}


- (void)dealloc {
    [@"tongzhi" removeObserver];
    
    [UIKeyboardWillShowNotification removeObserver];
}


@end

//
//  LoadingDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 17/1/3.
//
//

#import "LoadingDemoViewController.h"

#import "XCMStatePrompt.h"

@interface LoadingDemoViewController ()

@end

@implementation LoadingDemoViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:true];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:false];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 显示普通状态无配图
    UIButton *normalNoPicBtn = [self addButtonWithFrame:CGRectMake(100, 60, 150, 30) title:@"显示普通状态无配图" action:@selector(showNormalNoPic)];
    [self.view addSubview:normalNoPicBtn];
    normalNoPicBtn.setSize(CGSizeMake(100, 100));
    normalNoPicBtn.top(5).right(5);
    
    
    // 显示普通状态有配图
    UIButton *normalWithPicBtn = [self addButtonWithFrame:CGRectMake(100, 120, 150, 30) title:@"显示普通状态有配图" action:@selector(showNormalWithPic)];
    [self.view addSubview:normalWithPicBtn];
    normalWithPicBtn.top(5).left(5);
    
    // 显示正在加载
    UIButton *loadDataBtn = [self addButtonWithFrame:CGRectMake(100, 180, 150, 30) title:@"正在加载" action:@selector(loadData)];
    [self.view addSubview:loadDataBtn];
    loadDataBtn.setCenter();
    
    // 显示加载成功
    UIButton *loadSuccessBtn = [self addButtonWithFrame:CGRectMake(100, 240, 150, 30) title:@"加载成功" action:@selector(loadSuccess)];
    [self.view addSubview:loadSuccessBtn];
    loadSuccessBtn.left(5);
    
    // 显示加载失败
    UIButton *loadErrorBtn = [self addButtonWithFrame:CGRectMake(100, 300, 150, 30) title:@"加载失败" action:@selector(loadError)];
    [self.view addSubview:loadErrorBtn];
    loadErrorBtn.right(5);
    
    // 修改背景色
    UIButton *changeBackColorBtn = [self addButtonWithFrame:CGRectMake(100, 360, 150, 30) title:@"改变背景色" action:@selector(changeBackColor)];
    [self.view addSubview:changeBackColorBtn];
    changeBackColorBtn.bottom(5).left(5);
    
    // 修改标题颜色
    UIButton *changeTitleColorBtn = [self addButtonWithFrame:CGRectZero title:@"改变标题文字颜色" action:@selector(changeTitleColor)];
    changeTitleColorBtn.size = CGSizeMake(150, 30);
    [self.view addSubview:changeTitleColorBtn];
    changeTitleColorBtn.bottom(5).right(5);
}

/** 普通状态无配图 */
- (void)showNormalNoPic
{
    [XCMStatePrompt xcm_showStatePromptWithTitle:@"普通状态无配图" image:nil];
}

/** 普通状态有配图 */
- (void)showNormalWithPic
{
    [XCMStatePrompt xcm_showStatePromptWithTitle:@"普通状态有配图" image:[UIImage imageNamed:@"success"]];
}

/** 正在加载 */
- (void)loadData
{
    [XCMStatePrompt xcm_showStatePromptLoadingWithTitle:@"正在加载"];
}

/** 加载成功 */
- (void)loadSuccess
{
    [XCMStatePrompt xcm_showStatePromptSuccessWithTitle:@"加载成功"];
}

/** 加载失败 */
- (void)loadError
{
    [XCMStatePrompt xcm_showStatePromptErrorWithTitle:@"加载错误"];
}

/** 改变背景色 */
- (void)changeBackColor
{
    [XCMStatePrompt xcm_setStatePromptBackGroudColor:[UIColor redColor]];
}

/** 改变标题颜色 */
- (void)changeTitleColor
{
    [XCMStatePrompt xcm_setStatePromptTitleColor:[UIColor blueColor]];
}

#pragma mark - 加载button
- (UIButton *)addButtonWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    return button;
}

@end

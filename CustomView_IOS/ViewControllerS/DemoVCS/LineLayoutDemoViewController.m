//
//  LineLayoutDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/12.
//
//

#import "LineLayoutDemoViewController.h"

#import "JWScrollView.h"

#import "JWScrollviewCell.h"

@interface LineLayoutDemoViewController ()
@property (nonatomic,strong) JWScrollView * scrollView;
@end

@implementation LineLayoutDemoViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    UIView * view =[self.view.subviews firstObject];
    
    //需要设置线性布局控件集合的第一个控件的y轴，之后排列的控件不需要设置y轴 会自动向下排列
    UILabel * labe = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), kScreenWidth, 20)];
    labe.text = @"testlabel1";
    labe.backgroundColor = [UIColor redColor];
    
    UILabel * labe1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    labe1.text = @"testlabel2";
    labe1.backgroundColor = [UIColor blueColor];
    
    UILabel * labe2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    labe2.text = @"testlabel3";
    labe2.backgroundColor = [UIColor grayColor];
    
    JWTextField *
    text1 = [[JWTextField alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,50)];
    text1.placeholder = @"数字输入";
    text1.textAlignment = 0;
    text1.font = [UIFont systemFontOfSize:18];
    text1.importStyle = TextFieldImportStyleNumber; //设置输入限制的类型
    text1.keyboardType = UIKeyboardTypeNumberPad;
    text1.tag = 9999;
    text1.importBackString = ^(NSString * money){

    };

//    self.view.backgroundColor = [UIColor redColor];
    
    JWScrollviewCell * cell1 = [[JWScrollviewCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), kScreenWidth, 50)];
//    cell1.leftLabel.text = @"用户名";
    cell1.accessoryType = JWCellAccessoryDisclosureIndicator;
    cell1.rightTextField.placeholder = @"请输入用户名啊";
    cell1.isGestureEnabled = true;
    cell1.click=^(){
        NSLog(@"------");
    };
    cell1.accessoryType = JWCellAccessoryDisclosureIndicator;
    [cell1.rightTextField setPlaceholderColor:cell1.leftLabel.textColor];
    [cell1.rightTextField setPlaceholderFont:cell1.leftLabel.font];
    [cell1 setUPSpacing:1 andDownSpacing:1];
    //测试添加一个lab
    JWLabel * lab  = [[JWLabel alloc]initWithFrame:CGRectMake(0, 0, 100, cell1.contentView.height)];
    lab.text = @"13011151020";
    lab.tag = 1999;
    [cell1.contentView addSubview:lab];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"改变状态");
//        cell1.isGestureEnabled = false;
        ((JWLabel *)cell1.getElementByTag(1999)).text = @"哈哈哈哈哈";
    });

    
    
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:10];
    
    arr  = @[cell1].mutableCopy;
    
    for (int i = 0; i<5; i++) {
        JWScrollviewCell * cell2 = [[JWScrollviewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        cell2.leftLabel.text = [NSString stringWithFormat:@"用户名%d",i];
        cell2.rightTextField.placeholder = @"请输入用户名啊";
        [cell2.rightTextField setPlaceholderFont:cell1.leftLabel.font];
        [cell2 setUPSpacing:0 andDownSpacing:1];
        [arr addObject:cell2];
    }
    [self.scrollView setScrollviewSubViewsArr:arr];

    UIView * redview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    redview.backgroundColor = [UIColor redColor];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [arr insertObject:redview atIndex:1];
        
        self.scrollView.allSubviwes = arr;
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.scrollView reloadViews];
        } completion:^(BOOL finished) {
            
        }];
        
        
        
    });

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.scrollView removeViewWithTag:9999];
//        
//    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.scrollView setScrollviewSubViewsArr:@[labe,labe2,text1].mutableCopy];
//        
//    });

}

- (void)dealloc {
    [self clearNotificationAndGesture];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

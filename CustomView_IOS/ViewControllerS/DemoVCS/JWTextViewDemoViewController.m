//
//  JWTextViewDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/7.
//
//

#import "JWTextViewDemoViewController.h"
#import "JWTextView.h"
#import "JWScrollView.h"
#import "JWScrollviewCell.h"

@interface JWTextViewDemoViewController ()
@property (nonatomic,strong) JWScrollView * scrollView;
@end

@implementation JWTextViewDemoViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    UIView * view =[self.view.subviews firstObject];
    
    JWScrollviewCell * cell1 = [[JWScrollviewCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), kScreenWidth, 50)];
    
    JWTextView * textView = [[JWTextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    textView.backgroundColor = [UIColor redColor];
    textView.importStyle = TextViewImportStyleChina;
    textView.maxlength = 100;
    textView.font = [UIFont systemFontOfSize:20];
    textView.importBackString = ^(NSString * backStr){
//        NSLog(@"回调----%@",backStr);
    };
    textView.backHeight = ^(CGFloat height){
        cell1.contentView.height = height;
    };
    [cell1.contentView addSubview:textView];
    [cell1 setUPSpacing:5 andDownSpacing:5];
    
    JWScrollviewCell * cell2 = [[JWScrollviewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    cell2.leftLabel.text = @"用户";
    cell2.rightTextField.placeholder = @"用户名啊";
    [cell2.rightTextField setPlaceholderColor:cell1.leftLabel.textColor];
    [cell2.rightTextField setPlaceholderFont:cell1.leftLabel.font];
    [cell2 setUPSpacing:0 andDownSpacing:5];
    
    [self.scrollView setScrollviewSubViewsArr:@[view,cell1,cell2].mutableCopy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        cell2.contentView.height = 100;
        
    });

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect oldframe = [view convertRect:view.bounds toView:window];
    
    NSLog(@"相对于window的CGRect--------%@",NSStringFromCGRect(oldframe));
    
    NSLog(@"相对于view的CGRect--------%@",NSStringFromCGRect(view.frame));
    
}


@end

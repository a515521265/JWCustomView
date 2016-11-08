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

@interface JWTextViewDemoViewController () <CAAnimationDelegate>
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
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, kScreenHeight, 30);
    [btn setTitle:@"tapbuy" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shoppingCartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    [self.scrollView setScrollviewSubViewsArr:@[view,cell1,cell2,btn].mutableCopy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        cell2.contentView.height = 100;
        
    });


    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect oldframe = [view convertRect:view.bounds toView:window];
    
    NSLog(@"相对于window的CGRect--------%@",NSStringFromCGRect(oldframe));
    
    NSLog(@"相对于view的CGRect--------%@",NSStringFromCGRect(view.frame));
    
    
    
}

#pragma mark -购物车动画
-(void)shoppingCartButtonAction:(UIButton*)sender
{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common-hud1"]];
    imageView.contentMode=UIViewContentModeCenter;
    imageView.frame = sender.bounds;
    imageView.hidden=YES;
    CGPoint point= sender.frame.origin;
    imageView.center=point;
    CALayer *layer=[[CALayer alloc]init];
    layer.contents=imageView.layer.contents;
    layer.frame=imageView.frame;
    layer.opacity=1;
    [self.view.layer addSublayer:layer];
    //动画 终点 都以sel.view为参考系
    CGPoint endpoint= CGPointMake(20, kScreenHeight - 22);
    UIBezierPath *path=[UIBezierPath bezierPath];
    //动画起点
    CGRect rect=[sender convertRect: sender.bounds toView:self.view];
    CGPoint startPoint=CGPointMake(rect.origin.x +rect.size.width/2, rect.origin.y +rect.size.height/2);
    [path moveToPoint:startPoint];
    //贝塞尔曲线中间点
    float sx=startPoint.x;
    float sy=startPoint.y;
    float ex=endpoint.x;
    float ey=endpoint.y;
    float x=sx+(ex-sx)/3;
    float y=sy+(ey-sy)*0.5-400;
    CGPoint centerPoint=CGPointMake(x,y);
    [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration=0.8;
    animation.delegate=self;
    animation.autoreverses= NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:@"buy"];

}

//star
- (void)animationDidStart:(CAAnimation *)anim{

    //可以做一些拦截 避免连续点击
    NSLog(@"star");
    
}
//stop
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //释放拦截
    NSLog(@"stop");
}

@end

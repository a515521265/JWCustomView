//
//  ShoppingCartDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/8.
//
//

#import "ShoppingCartDemoViewController.h"
#import "JWScrollView.h"
#import "JWScrollviewCell.h"
#import "GoodsModel.h"
#import "CompanyModel.h"
#import "SpecsModel.h"

@interface ShoppingCartDemoViewController () <CAAnimationDelegate>
@property (nonatomic,strong) JWScrollView * scrollView;
@property (nonatomic,strong) UIButton * clearingbtn;
@property (nonatomic,strong) NSMutableArray <CompanyModel *> * modelArr;

@end

@implementation ShoppingCartDemoViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-50);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray * viewsArr = [NSMutableArray arrayWithCapacity:10];
    
    
    self.modelArr = [NSMutableArray arrayWithCapacity:10];
    
    
    CompanyModel * companymodel = [CompanyModel new]; //公司
    companymodel.companyName = @"恒善信诚";
    

    GoodsModel * goods1 = [GoodsModel new]; //产品
    goods1.goodsName = @"大虾";
    
    GoodsModel * goods2 = [GoodsModel new]; //产品
    goods2.goodsName = @"小虾米";
    
    
    SpecsModel * specs1 =  [SpecsModel new]; //规格
    specs1.specsName = @"蓝色大虾";
    specs1.specsid = 1;
    
    SpecsModel * specs2 =  [SpecsModel new]; //规格
    specs2.specsName = @"黑色大虾";
    specs1.specsid = 2;
    
    SpecsModel * specs3 =  [SpecsModel new]; //规格
    specs3.specsName = @"蓝色小虾米";
    specs3.specsid = 3;
    
    SpecsModel * specs4 =  [SpecsModel new]; //规格
    specs4.specsName = @"黑色小虾米";
    specs4.specsid = 4;
    
    companymodel.goodsArr = @[goods1,goods2];
    
    goods1.specsArr = @[specs1,specs2];
    
    goods2.specsArr = @[specs3,specs4];
    
    [self.modelArr addObjectsFromArray:@[companymodel]];
    
    for (int i = 0 ; i< self.modelArr.count; i++) {
        JWScrollviewCell * cell = [self CreateJWCell:self.modelArr[i]];
        [viewsArr addObject:cell];
    }
    [self.scrollView setScrollviewSubViewsArr:viewsArr];

    //底部按钮
    JWScrollviewCell * cell = [[JWScrollviewCell alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    [cell setUPSpacing:1 andDownSpacing:1];
    self.clearingbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clearingbtn.frame = CGRectMake(kScreenWidth-150, 0, 150, 50);
    [self.clearingbtn setBackgroundColor:[UIColor redColor]];
    [self.clearingbtn setTitle:@"去结算(0)" forState:UIControlStateNormal];
    [self.clearingbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.contentView addSubview:self.clearingbtn];
    
    [self.view addSubview:cell];
    
    
}

-(JWScrollviewCell *)CreateJWCell:(CompanyModel *)model {

    JWScrollviewCell * cell = [[JWScrollviewCell alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
    [cell setUPSpacing:5 andDownSpacing:5];
    
    UIView * companyView = [self companyView:model.companyName];
    [cell.contentView addSubview:companyView];
    
    for (int i = 0; i<model.goodsArr.count; i++) {
        UIView * goodsView = [self goodsView:model.goodsArr[i]];
        goodsView.y = CGRectGetMaxY(cell.contentView.subviews.lastObject.frame);
        [cell.contentView addSubview:goodsView];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.contentView.height = CGRectGetMaxY(cell.contentView.subviews.lastObject.frame);
    });
    return cell;
}

-(UIView *)companyView:(NSString *)name{

    UIView * companyView = [[UIView alloc]init];
    companyView.frame = CGRectMake(0, 0, kScreenWidth, 30);
    companyView.backgroundColor = [UIColor grayColor];
    JWLabel * lab = [[JWLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    lab.text = name;
    [companyView addSubview:lab];
    return companyView;
    
}

-(UIView *)goodsView:(GoodsModel *)goodsmodel{
    
    UIView * goods = [[UIView alloc]init];
    goods.frame = CGRectMake(0, 0, kScreenWidth, 50);
    goods.backgroundColor = [UIColor blueColor];
    JWLabel * lab = [[JWLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    lab.text = goodsmodel.goodsName;
    [goods addSubview:lab];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(kScreenWidth-70, 0, 50, 50);
    [btn setTitle:@"买买买" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shoppingCartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [goods addSubview:btn];
    
    for (int i = 0; i < goodsmodel.specsArr.count; i++) {
        UIView * specificationsView = [self specificationsView:goodsmodel.specsArr[i]];
        specificationsView.y = CGRectGetMaxY(goods.subviews.lastObject.frame);
        [goods addSubview:specificationsView];
    }
    
    goods.height = CGRectGetMaxY(goods.subviews.lastObject.frame);
    
    return goods;
    
}

-(UIView *)specificationsView:(SpecsModel *)specsModel{
    
    UIView * specificationsView = [[UIView alloc]init];
    specificationsView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    specificationsView.backgroundColor = [UIColor yellowColor];
    JWLabel * lab = [[JWLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    lab.text = specsModel.specsName;
    [specificationsView addSubview:lab];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(kScreenWidth-70, 0, 50, 40);
    btn.tag = specsModel.specsid + 1000;
    [btn setTitle:@"删删删" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deletespecificationsView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [specificationsView addSubview:btn];

    return specificationsView;
    
}

-(void)deletespecificationsView:(UIButton *)btn{
    
    UIView * btnSuperview = btn.superview;
    
    JWScrollviewCell * supersuperView = (JWScrollviewCell *)btnSuperview.superview.superview.superview;
    
    
    [btnSuperview removeFromSuperview];
    
    CompanyModel * companymodel = self.modelArr.firstObject;
    
    //公司view
//    supersuperView.contentView;
    
    
    
    
    //先拿到这个公司，在拿到这个产品 在拿到产品规格
    
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
    CGPoint endpoint= CGPointMake(22, kScreenHeight - 22);
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
    static int num = 1;
    [self.clearingbtn setTitle:[NSString stringWithFormat:@"去结算(%d)",num++] forState:UIControlStateNormal];
}


@end

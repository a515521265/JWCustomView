//
//  HeadlineView.m
//  松鼠金融借款服务
//
//  Created by 薄睿杰 on 16/4/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "HeadlineView.h"
#import "bannerData.h"
#import "JWKitMacro.h"
#import "YYWeakProxy.h"

@interface HeadlineView ()
{
    
    NSTimer *_timer;
    int count;
    int flag;
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong) UIView *currentView;
@property (nonatomic,strong) UIView *hidenView;
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UIButton *currentBtn;
@property (nonatomic,strong) UIButton *hidenBtn;
@property (nonatomic,strong) UILabel *hidenLabel;
@end

@implementation HeadlineView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = UIColorFromRGB(0xf7fcff);
//        UIImageView *imageV = [[UIImageView alloc] initWithFrame:resetRectXYWH(15, 8, 34, 24)];
//        imageV.image = [UIImage imageNamed:@"home-gonggao"];
//        [self addSubview:imageV];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    count = 0;
    flag = 0;
    
    self.layer.masksToBounds = YES;
    
    [self createTimer];
    [self createCurrentView];
    [self createHidenView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
    [self addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [self addGestureRecognizer:longPress];
    
}
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr
{
    if (dataArr.count!=0)
    {
        _dataArr = dataArr;
        bannerData *model = _dataArr[count];
        self.currentLabel.text = model.title;
    }
}


-(void)dealLongPress:(UILongPressGestureRecognizer*)longPress{
    
    if(longPress.state==UIGestureRecognizerStateEnded){
        
        _timer.fireDate=[NSDate distantPast];
        
        
    }
    if(longPress.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
    }
}
- (void)dealTap:(UITapGestureRecognizer *)tap
{
    self.clickBlock(count);
}

- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(dealTimer) userInfo:nil repeats:YES];
}

-(void)dealTimer
{
    count++;
    if (count == _dataArr.count) {
        count = 0;
    }
    
    if (flag == 1) {
        bannerData*currentModel = _dataArr[count];
        self.currentLabel.text = currentModel.title;
    }
    
    if (flag == 0) {
        bannerData *hienModel = _dataArr[count];
        self.hidenLabel.text = hienModel.title;
    }
    
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 1;
            self.currentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 0;
            self.hidenView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)createCurrentView
{
    bannerData *model = _dataArr[count];
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.currentView];
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(59,10,kScreenWidth - 59,20)];
    self.currentLabel.text = model.title;
    self.currentLabel.textColor = UIColorFromRGB(0X4c5f70);
    self.currentLabel.font = [UIFont systemFontOfSize:13];
    [self.currentView addSubview:self.currentLabel];
}

- (void)createHidenView
{
    self.hidenView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.hidenView];
    self.hidenLabel = [[UILabel alloc]initWithFrame:CGRectMake(59,10,kScreenWidth - 59,20)];
    self.hidenLabel.text = @"";
    self.hidenLabel.textColor = UIColorFromRGB(0X4c5f70);
    self.hidenLabel.font = [UIFont systemFontOfSize:13];
    [self.hidenView addSubview:self.hidenLabel];
}

- (void)stopTimer
{
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end

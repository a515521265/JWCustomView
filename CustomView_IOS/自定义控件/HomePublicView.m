//
//  HomePublicView.m
//  松鼠金融借款服务
//
//  Created by 薄睿杰 on 16/4/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "HomePublicView.h"

#import "AdView.h"

#import "HeadlineView.h"

@interface HomePublicView ()

@property (strong, nonatomic) AdView * adView;

@property (strong, nonatomic) HeadlineView * headlineView;

@end

@implementation HomePublicView

-(instancetype)initWithHomeAdViewFrame:(CGRect)frame{

    self =[super init];
    
    
    if (self) {
    
        self.frame = frame;
        
        __block HomePublicView * weakSelf = self;
        
        
        self.adView = [[AdView alloc]initWithFrame:self.bounds];
        [self.adView setimageLinkURL:_imageList];
        [self.adView setPageControlShowStyle:UIPageControlShowStyleCenter];
        self.adView.adMoveTime = 5.0;
        self.adView.callBack = ^(NSInteger index,NSString * imageURL){
            [weakSelf adtap:index];
        };
        [self addSubview:self.adView];
    }
    return self;
}
-(void)setImageList:(NSArray *)imageList
{
    [self.adView setimageLinkURL:imageList];
    self.adView.imageLinkURL  =imageList;
    [self.adView setPageControlShowStyle:UIPageControlShowStyleCenter];
}

-(void)adtap:(NSInteger)index{
    !_TapADindex ? : _TapADindex(index);
}


-(instancetype)initWithHomeHeadlineViewFrame:(CGRect)frame{

    self =[super init];
    
    if (self) {
        
        __block HomePublicView * weakSelf = self;
        
        self.frame = frame;
        self.headlineView = [[HeadlineView alloc]initWithFrame:self.bounds];
        
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:1];
        
        [self.headlineView setVerticalShowDataArr:arr];
        self.headlineView.clickBlock = ^ (NSInteger index){
            [weakSelf headlineTap:index];
        };
        [self addSubview:self.headlineView];
    }
    return self;
}

-(void)setHeadlineList:(NSMutableArray *)headlineList{
    [self.headlineView setVerticalShowDataArr:headlineList];
}

-(void)headlineTap:(NSInteger)index{
    !_TapHeadlineindex ? : _TapHeadlineindex(index);
}
-(instancetype)initWithHomeTowBtnViewFrame:(CGRect)frame{
    self =[super init];
    
    if (self) {
        
        self.frame = frame;
        
        UIButton * downRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        downRightButton.frame = CGRectMake(0, 0, 159, 185);
        downRightButton.backgroundColor = [UIColor clearColor];
        [downRightButton setBackgroundImage:[UIImage imageNamed:@"home_daihuanxinyongka_morePreferential"] forState:UIControlStateNormal];
        downRightButton.tag = 1001;
        [downRightButton setBackgroundImage:[UIImage imageNamed:@"home_daihuanxinyongka_morePreferential_xuanzhong"] forState:UIControlStateHighlighted];
        [downRightButton addTarget:self action:@selector(tapbtnS:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downRightButton];

        
        UIButton *downMiddleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        downMiddleButton.frame = CGRectMake(161, 0, 159, 185);
        downMiddleButton.backgroundColor = [UIColor clearColor];
        [downMiddleButton setBackgroundImage:[UIImage imageNamed:@"home_likejiexianjin"] forState:UIControlStateNormal];
        [downMiddleButton setBackgroundImage:[UIImage imageNamed:@"home_likejiexianjin_xuanzhong"] forState:UIControlStateHighlighted];
        downMiddleButton.tag = 1002;
        [downMiddleButton addTarget:self action:@selector(tapbtnS:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downMiddleButton];
        
        
        UIImageView * verticalDivider = [[UIImageView alloc] initWithFrame:CGRectMake(159, 5, 2, 175)];
        verticalDivider.image = [UIImage imageNamed:@"divider_v"];
        [self addSubview:verticalDivider];
        
    }
    return self;
}

-(void)tapbtnS:(UIButton *)btn{
    !_TapbtnsTitle ? : _TapbtnsTitle (btn.tag);
}

-(instancetype)initWithHomeBottomViewFrame:(CGRect)frame{
    self =[super init];
    
    if (self) {
        
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 320, 85);
        rightButton.backgroundColor = [UIColor clearColor];
        
        [rightButton setBackgroundImage:[UIImage imageNamed:@"home_woyaohuankuan"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"home_woyaohuankuan_xuanzhong"] forState:UIControlStateHighlighted];
        [rightButton addTarget:self action:@selector(easilyAlsoMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        
    }
    return self;
}
-(void)easilyAlsoMethod{
    !_TapBottomView ? : _TapBottomView();
}
@end

//
//  HomePublicView.h
//  松鼠金融借款服务
//
//  Created by 薄睿杰 on 16/4/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePublicView : UIView

#pragma mark 首页轮播图View
@property (nonatomic,strong) NSArray * imageList;
@property (nonatomic,copy  ) void(^TapADindex)(NSInteger);
-(instancetype)initWithHomeAdViewFrame:(CGRect)frame;
#pragma mark 首页头条View
@property (nonatomic,strong) NSMutableArray * headlineList;
@property (nonatomic,copy  ) void(^TapHeadlineindex)(NSInteger);
-(instancetype)initWithHomeHeadlineViewFrame:(CGRect)frame;
#pragma mark 首页两个按钮View
@property (nonatomic,copy  ) void(^TapbtnsTitle)(NSInteger );
-(instancetype)initWithHomeTowBtnViewFrame:(CGRect)frame;
#pragma mark 首页底部View
@property (nonatomic,copy  ) dispatch_block_t  TapBottomView;

-(instancetype)initWithHomeBottomViewFrame:(CGRect)frame;

@end

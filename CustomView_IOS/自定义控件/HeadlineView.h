//
//  HeadlineView.h
//  松鼠金融借款服务
//
//  Created by 薄睿杰 on 16/4/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadlineView : UIView

@property (nonatomic,copy) void (^clickBlock)(NSInteger index);

- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr;

- (void)stopTimer;

@end

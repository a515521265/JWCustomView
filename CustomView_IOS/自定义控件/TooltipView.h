//
//  TooltipView.h
//  songShuFinance
//
//  Created by 梁家文 on 15/10/16.
//  Copyright (c) 2015年 李贵文. All rights reserved.
//

#import <UIKit/UIKit.h>
#define durationTime 2.0f

@interface TooltipView : UIView
{
    NSString *_text;
    UIButton *_contentView;
    CGFloat _duration;
}
+ (void)showWithText:(NSString *)text;
@end

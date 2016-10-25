//
//  TooltipView.m
//  songShuFinance
//
//  Created by 梁家文 on 15/10/16.
//  Copyright (c) 2015年 李贵文. All rights reserved.
//

#import "TooltipView.h"

@implementation TooltipView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}
- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        _text = [text copy];
        
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 12, textSize.height + 12)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 7.0f;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        _contentView.backgroundColor = [UIColor colorWithRed:0.0f
                                                       green:0.0f
                                                        blue:0.0f
                                                       alpha:1.0f];
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self
                         action:@selector(toastTaped:)
               forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        
        _duration = durationTime;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}
+ (void)showWithText:(NSString *)text
{
    [self showWithText:text duration:durationTime];
}

+ (void)showWithText:(NSString *)text duration:(CGFloat)duration
{
    TooltipView *toast = [[TooltipView alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}
- (void)setDuration:(CGFloat)duration
{
    _duration = duration;
}
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = window.center;
    [window addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}
- (void)showAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.alpha = 0.5;
    }];
}
- (void)toastTaped:(UIButton *)button
{
    [self hideAnimation];
}
- (void)deviceOrientationDidChanged:(NSNotification *)aNotification
{
    [self hideAnimation];
}
- (void)hideAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissToast];
    }];
}
- (void)dismissToast
{
    [_contentView removeFromSuperview];
}
@end

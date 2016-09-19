//
//  JWScrollviewCell.h
//  CustomView_IOS
//
//  Created by 梁家文 on 16/9/16.
//
//

#import <UIKit/UIKit.h>
#import "JWLabel.h"
#import "JWTextField.h"

@interface JWScrollviewCell : UIView

@property (nonatomic,strong) UIView * contentView;

@property (nonatomic,strong) JWLabel * leftLabel;

@property (nonatomic,strong) JWTextField * rightTextField;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)setUPSpacing:(CGFloat)upSpacing andDownSpacing:(CGFloat)downSpacing;

@end

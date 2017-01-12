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

typedef NS_ENUM(NSInteger, CellAccessoryType) {
    JWCellAccessoryNone,
    JWCellAccessoryDisclosureIndicator
};

@interface JWScrollviewCell : UIView

@property (nonatomic,strong) UIView * contentView;

@property (nonatomic,strong) JWLabel * leftLabel;

@property (nonatomic,strong) JWTextField * rightTextField;

@property (nonatomic,strong) UIColor * lineColor;

@property (nonatomic,assign) CellAccessoryType accessoryType;

@property (nonatomic,assign) dispatch_block_t   click;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)setUPSpacing:(CGFloat)upSpacing andDownSpacing:(CGFloat)downSpacing;

-(void)refreshSubviews;

@end

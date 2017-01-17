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
//内容view，cell子控件需要加到这个view上面
@property (nonatomic,strong) UIView * contentView;
//左边标签
@property (nonatomic,strong) JWLabel * leftLabel;
//右边输入框
@property (nonatomic,strong) JWTextField * rightTextField;
//间距颜色
@property (nonatomic,strong) UIColor * lineColor;
//设置cell风格，目前只有一个
@property (nonatomic,assign) CellAccessoryType accessoryType;
//设置按钮点击事件
@property (nonatomic,assign) BOOL isGestureEnabled;
//点击回调
@property (nonatomic,  copy) void(^click)();

-(instancetype)initWithFrame:(CGRect)frame;
//设置上下间距
-(void)setUPSpacing:(CGFloat)upSpacing andDownSpacing:(CGFloat)downSpacing;

-(void)refreshSubviews;
//根据tag拿到一个view，需要注意这个view只能是在contentView中的，否则会拿到nil
-(UIView *(^)(NSInteger))getElementByTag;

@end

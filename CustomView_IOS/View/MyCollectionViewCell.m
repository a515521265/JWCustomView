//
//  MyCollectionViewCell.m
//  测试流布局
//
//  Created by 恒善信诚科技有限公司 on 16/9/9.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "UIView+Extension.h"

@interface MyCollectionViewCell ()

@property (nonatomic,strong) UILabel * label;

@end


@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
     
        _label = [UILabel new];
        _label.frame = CGRectMake(0, 0,self.width, self.height);
        _label.textAlignment = 1;
//        _label.text = @"label";
        [self addSubview:_label];
        
    }
    
    return self;
}

-(void)setLabText:(NSString *)labText{

    _label.text = labText;
    
}


@end

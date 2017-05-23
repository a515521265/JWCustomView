//
//  CustomTableViewCell.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/23.
//
//

#import "CustomTableViewCell.h"
#import "JWKitMacro.h"
@implementation CustomTableViewCell

-(void)setCellModel:(CustomCellModel *)cellModel{

    _cellModel = cellModel;
    
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0 ; i< cellModel.list.count; i++) {
        
        NSInteger a = i / 5;
        NSInteger b = i % 5;
        
        UIView * progress =  [[UIView alloc] initWithFrame:CGRectMake(b * kScreenWidth / 5,(a * kScreenWidth / 5), kScreenWidth / 5, kScreenWidth / 5)];
        progress.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [self addSubview:progress];
        
    }
    
    _cellModel.cellHeight = CGRectGetMaxY(self.subviews.lastObject.frame);

}


@end

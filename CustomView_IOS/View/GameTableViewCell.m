//
//  GameTableViewCell.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/23.
//
//

#import "GameTableViewCell.h"
#import "JWKitMacro.h"
#import "UIView+Extension.h"

@implementation GameTableViewCell

-(void)setCellModel:(CustomCellModel *)cellModel{
    
    _cellModel = cellModel;
    
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    int x = arc4random() % 4;

    
    for (int i = 0 ; i< cellModel.list.count; i++) {
        
        NSInteger a = i / 4;
        NSInteger b = i % 4;
        
        UIView * progress =  [[UIView alloc] initWithFrame:CGRectMake(b * kScreenWidth / 4,(a * kScreenWidth / 3), kScreenWidth / 4, kScreenWidth / 3)];
        progress.backgroundColor = [UIColor whiteColor];
        progress.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色
        progress.layer.borderWidth = 0.5;//边框宽度
        if (x == i) {
            progress.backgroundColor = [UIColor blackColor];
        }

        if (progress.backgroundColor == [UIColor blackColor]) {
            HXWeak_self
            [progress addSingleTapEvent:^{
                HXStrong_self
                !self.tapBlack ? : self.tapBlack();
            }];
        }else{
            HXWeak_self
            [progress addSingleTapEvent:^{
                HXStrong_self
                !self.tapWhite ? : self.tapWhite();
            }];

        }
        
        [self addSubview:progress];
        
    }
    
    _cellModel.cellHeight = CGRectGetMaxY(self.subviews.lastObject.frame);
    
}


@end

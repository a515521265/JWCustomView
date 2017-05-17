//
//  GridTableViewCell.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/17.
//
//

#import "GridTableViewCell.h"
#import "JWKitMacro.h"

static int sizes = 3;

@implementation GridTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
    
}

-(void)setModels:(NSArray *)models{

    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }

    for (int i = 0; i<models.count; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(i*kScreenWidth/sizes, 0, kScreenWidth/sizes, kScreenWidth/sizes)];
        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [self setviewcolor:view];
        [self addSubview:view];
    }
    
}

-(void)setviewcolor:(UIView *)view{

    [UIView animateWithDuration:0.5 animations:^{
        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    
}

@end

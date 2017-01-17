//
//  JWScrollView.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/12.
//
//

#define kScreenFrame    [UIScreen mainScreen].bounds
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

#import "JWScrollView.h"

#import "UIView+Extension.h"

@interface JWScrollView ()


@end

@implementation JWScrollView

-(void)setScrollviewSubViewsArr:(NSMutableArray *)views{
    
    self.allSubviwes = views;
    
    [self reloadSubViews:self.allSubviwes];
    
}

-(void)reloadSubViews:(NSMutableArray<UIView *> *)views{
    
    if (!views.count)return;
    UIView * firstView = [views firstObject];
    firstView.tag = 1992;
    firstView.x = (kScreenWidth - firstView.width)/2;
    if (self.isGestureEnabled) {
        UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
        firstTap.numberOfTapsRequired = 1;
        firstTap.numberOfTouchesRequired = 1;
        [firstView addGestureRecognizer:firstTap];
    }
    [self addSubview:firstView];
    
    for (int i =1; i<views.count; i++) {
        UIView * view = views[i];
        view.tag = 1992+i;
        view.x = (kScreenWidth - view.width)/2;
        if (self.isGestureEnabled) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [view addGestureRecognizer:tap];
        }
        view.y = self.subviews.lastObject.y + self.subviews.lastObject.height;
        [self addSubview:view];
        
        if (i == views.count-1) {
            self.contentSize = CGSizeMake(0, self.subviews.lastObject.y + self.subviews.lastObject.height+self.paddingHeight);
        }
    }

}

-(void)viewTapAction:(UITapGestureRecognizer *)tap{
    
    !_tapSelectRow ? : _tapSelectRow(tap.view.tag-1992);
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self reloadSubViews:self.allSubviwes];
}


-(void)removeViewWithTag:(NSInteger)ViewTag{
    
    [self.allSubviwes enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.tag ==ViewTag) {
            [obj removeFromSuperview];
            [self.allSubviwes removeObjectAtIndex:idx];
        }
    }];
    
    [self reloadSubViews:self.allSubviwes];
    
}

-(void)removeAllSubViews{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
        
    }];
}

-(void)reloadViews{
    
    [self reloadSubViews:self.allSubviwes];
    
}

-(void)allSubViewsClipsToBounds{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.clipsToBounds = true;
        
    }];
    
}

@end

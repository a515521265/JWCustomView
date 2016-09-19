//
//  JWScrollView.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/12.
//
//

#import "JWScrollView.h"

#import "UIView+Extension.h"

@interface JWScrollView ()

//@property (nonatomic,strong) NSMutableArray <UIView *> * subViewsArr;

@end

@implementation JWScrollView

-(void)setScrollviewSubViewsArr:(NSMutableArray *)views{
    
    self.allSubviwes = views;
    
    [self reloadSubViews:self.allSubviwes];
    
}

-(void)reloadSubViews:(NSMutableArray<UIView *> *)views{
    
    if (!views.count)return;
    UIView * view = [views firstObject];
    [self addSubview:view];
    for (int i =1; i<views.count; i++) {
        UIView * view = views[i];
        view.y = self.subviews.lastObject.y + self.subviews.lastObject.height;
        [self addSubview:view];
        
        if (i == views.count-1) {
            self.contentSize = CGSizeMake(0, self.subviews.lastObject.y + self.subviews.lastObject.height);
        }
    }
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

@end

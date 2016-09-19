//
//  JWScrollView.h
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/12.
//
//

#import <UIKit/UIKit.h>

@interface JWScrollView : UIScrollView

@property (nonatomic,strong) NSMutableArray <UIView *> * allSubviwes;

-(void)setScrollviewSubViewsArr:(NSMutableArray *)views;

-(void)removeViewWithTag:(NSInteger)ViewTag;

-(void)reloadViews;

-(void)removeAllSubViews;

@end

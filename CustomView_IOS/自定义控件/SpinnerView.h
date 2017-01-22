//
//  SpinnerView.h
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 17/1/22.
//
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

-(instancetype)initShowSpinnerWithRelevanceView:(UIView *)view;

@property (nonatomic,strong)NSMutableArray * modelArr;

@property (nonatomic, copy) void(^backModel)(id );

@property (nonatomic,assign) BOOL  isNavHeight;

-(void)ShowView;

-(void)hiddenView;

@end

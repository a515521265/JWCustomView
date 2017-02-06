//
//  SpinnerView.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 17/1/22.
//
//

#import "SpinnerView.h"
#import "UIView+Extension.h"
#import "JWKitMacro.h"

@interface SpinnerView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * spinnerTableView;/**< 表视图 */

@property (nonatomic,strong) UIView * relevanceView;

@property (nonatomic,strong) UIWindow * window;

@property (nonatomic,strong) UIView * shieldView;

@property (nonatomic,assign) BOOL up;

@end


@implementation SpinnerView

-(UIWindow *)window{

    if (!_window) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        _window = window;
        _window.clipsToBounds = true;
        [_window addSubview:self.shieldView];
    }
    return _window;
}

-(UIView *)shieldView{

    if (!_shieldView) {
        _shieldView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _shieldView.backgroundColor = [UIColor clearColor];
        HXWeak_self
        [_shieldView addSingleTapEvent:^{
            HXStrong_self
            if (self.tapDisappear) {
                [self hiddenView];
            }
        }];
    }
    return _shieldView;
}

-(instancetype)initShowSpinnerWithRelevanceView:(UIView *)view{
 
    self.relevanceView = view;
    
    self = [super initWithFrame:CGRectMake(view.x, view.y+view.height, view.width, 0)];
    if (self) {

        self.spinnerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
        self.spinnerTableView.delegate = self;
        self.spinnerTableView.dataSource = self;
        [self addSubview:self.spinnerTableView];
    }
    return self;
}

#pragma mark - 设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.modelArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    !_backModel ? : _backModel (self.modelArr[indexPath.row]);
    [self hiddenView];
}

#pragma mark - 设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(spinnerItemHeight)]) {
        return [self.delegate spinnerItemHeight];
    }else{
        return self.relevanceView.height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)setModelArr:(NSMutableArray *)modelArr{
    _modelArr = modelArr;
}

-(void)ShowView{
    
    [self.window addSubview:self];

    CGRect  rect = self.getRelativewindowFrame(self.relevanceView);
    self.y = CGRectGetMaxY(rect);
    
    if (rect.origin.y > (kScreenHeight - [self getViewJWHeight] - (self.isNavHeight ? 64:0))) {
        self.y = (rect.origin.y - [self getViewJWHeight]) + [self getViewJWHeight];
        self.height = 0;
        [UIView animateWithDuration:0.15 animations:^{
            self.y = (rect.origin.y - [self getViewJWHeight]);
            [self settingHeight];
        } completion:^(BOOL finished) {
            
        }];
        self.up = true;
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            [self settingHeight];
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)settingHeight{

    if (_modelArr.count>5) {
        self.height = self.spinnerTableView.height = self.relevanceView.height * 5;
    }else{
        self.height = self.spinnerTableView.height = _modelArr.count*self.relevanceView.height;
    }
    
    [[self layer] setShadowOffset:CGSizeMake(1, 3)];
    [[self layer] setShadowRadius:5];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowColor:[UIColor grayColor].CGColor];
}

-(CGFloat)getViewJWHeight{
    CGFloat Jheight = 0;
    if (_modelArr.count>5) {
        Jheight = self.relevanceView.height * 5;
    }else{
        Jheight = _modelArr.count*self.relevanceView.height;
    }
    return Jheight;
}


-(void)hiddenView{

    
    if (self.up) {
        [UIView animateWithDuration:0.15 animations:^{
            self.y = self.y + [self getViewJWHeight];
            self.height = self.spinnerTableView.height = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.shieldView removeFromSuperview];
        }];
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            self.height = self.spinnerTableView.height = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.shieldView removeFromSuperview];
        }];
    }
    

}

@end

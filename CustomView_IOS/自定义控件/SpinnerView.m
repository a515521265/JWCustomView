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

@end


@implementation SpinnerView

-(instancetype)initShowSpinnerWithRelevanceView:(UIView *)view{
 
    self.relevanceView = view;
    
    self = [super initWithFrame:CGRectMake(view.x, view.y+view.height, view.width, 0)];
    if (self) {

        self.spinnerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
        self.spinnerTableView.delegate = self;
        self.spinnerTableView.dataSource = self;
        [self addSubview:self.spinnerTableView];
        
        [view.superview addSubview:self];
        
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
//    cell.textLabel.font = kLightFont(14);
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
    return self.relevanceView.height;
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
    CGRect  rect = self.getRelativewindowFrame(self.relevanceView);
    [self settingHeight];
    if (rect.origin.y > (kScreenHeight - self.height - (self.isNavHeight ? 64:0))) {
        self.y = (rect.origin.y - self.height);
    }
    CGAffineTransform originTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformScale(self.transform, 0.9, 0.9);
    self.transform = scaleTransform;
    [UIView animateWithDuration:0.15f delay:0.f options:UIViewAnimationOptionAllowUserInteraction &UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = originTransform;
    } completion:nil];
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


-(void)hiddenView{
    
    CGAffineTransform originTransform = CGAffineTransformScale(self.transform, 0.9, 0.9);
    CGAffineTransform scaleTransform = self.transform;
    self.transform = scaleTransform;
    [UIView animateWithDuration:0.15f delay:0.f options:UIViewAnimationOptionAllowUserInteraction &UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = originTransform;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end

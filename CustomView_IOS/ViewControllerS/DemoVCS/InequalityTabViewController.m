//
//  InequalityTabViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/23.
//
//

#import "InequalityTabViewController.h"
#import "CustomTableViewCell.h"
#import "CustomCellModel.h"
#import "YYModel.h"

@interface InequalityTabViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) NSMutableArray * models;

@end

@implementation InequalityTabViewController

-(NSMutableArray *)dataArr{

    if (!_dataArr) {
        _dataArr = @[@{@"list" : @[@"",@"",@"",@"",@"",@""]},
                     @{@"list" : @[@"",@"",@""]},
                     @{@"list" : @[@"",@""]},
                     @{@"list" : @[@"",@"",@"",@"",@""]},
                     @{@"list" : @[@""]},
                     @{@"list" : @[@"",@"",@""]},
                     @{@"list" : @[@"",@"",@"",@"",@""]},
                     @{@"list" : @[@"",@"",@""]},
                     @{@"list" : @[@"",@""]},
                     @{@"list" : @[@"",@"",@"",@"",@""]},
                     @{@"list" : @[@""]},
                     @{@"list" : @[@"",@"",@""]}].mutableCopy;
    }
    return _dataArr;
    
}

-(NSMutableArray *)models{

    if (!_models) {
        _models = @[].mutableCopy;
        for (int i =0; i< self.dataArr.count; i++) {
            CustomCellModel * model = [CustomCellModel yy_modelWithDictionary:self.dataArr[i]];
            [_models addObject:model];
        }
    }
    return _models;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIView * view = [self.view.subviews firstObject];
    view.hidden = true;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.showsVerticalScrollIndicator = FALSE;
    _tableView.showsHorizontalScrollIndicator = FALSE;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.delaysContentTouches = false;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}

#pragma mark - 设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.cellModel = self.models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - 设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.models.count;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCellModel * model = self.models[indexPath.row];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end

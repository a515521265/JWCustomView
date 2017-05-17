//
//  QQTextViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/5.
//
//

#import "QQTextViewController.h"
#import "TextModel.h"

@interface QQTextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray<TextModel *> * dataArr;
@end

@implementation QQTextViewController

-(NSMutableArray *)dataArr{

    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
    
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.delaysContentTouches = false;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
}

static BOOL reload;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self tableView];
    
    NSMutableArray * arrrrr = @[
                                @{@"title":@"小学同学",
                                  @"contentS":@[@"吃1",@"吃2",@"吃3",@"吃4",@"吃5"],
                                  @"isShow":@false},
                                
                                @{@"title":@"中学同学",
                                  @"contentS":@[@"喝1",@"喝2",@"喝3",@"喝4",@"喝5"],
                                  @"isShow":@false},
                                
                                @{@"title":@"高中同学",
                                  @"contentS":@[@"玩1",@"玩2",@"玩3",@"玩4",@"玩5"],
                                  @"isShow":@false},
                                
                                @{@"title":@"大学同学",
                                  @"contentS":@[@"乐1",@"乐2",@"乐3",@"乐4",@"乐5"],
                                  @"isShow":@false},
                                
                                ].mutableCopy;
    
    for (int i = 0; i< arrrrr.count; i++) {
        TextModel * mode = [TextModel itemWithDcit:arrrrr[i]];
        [self.dataArr addObject:mode];
    }
    
    
}

#pragma mark - 设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    TextModel * dict = self.dataArr[indexPath.section];
    cell.textLabel.text = dict.contentS[indexPath.row];
    return cell;
    
}

#pragma mark - 设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

#pragma mark - 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (reload==false) {
        return 0;
    }
    TextModel * dict = self.dataArr[section];
    if (dict.isShow==false) {
        return 0;
    }
    return dict.contentS.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50);
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(20, 0, 200, 50);
    TextModel * dict = self.dataArr[section];
    lab.text = dict.title;
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.font = [UIFont systemFontOfSize:13];
    [view addSingleTapEvent:^{
        reload = true;
        TextModel * dict = self.dataArr[section];
        dict.isShow = !dict.isShow;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
//        [UIView transitionWithView: self.tableView
//                          duration: 0.35f
//                           options: UIViewAnimationOptionTransitionCrossDissolve
//                        animations: ^(void)
//         {
//             [self.tableView reloadData];
//         }
//                        completion: ^(BOOL isFinished)
//         {
//             /* TODO: Whatever you want here */
//         }];
    }];
    [view addSubview:lab];
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end

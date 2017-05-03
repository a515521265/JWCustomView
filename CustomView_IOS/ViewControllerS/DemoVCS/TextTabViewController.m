//
//  TextTabViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/4/28.
//
//

#import "TextTabViewController.h"

@interface TextTabViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * leftTableView;
@property (nonatomic,strong) NSMutableArray * leftArr;
@property (nonatomic,strong) UITableView * rightTableView;
@property (nonatomic,strong) NSMutableArray * rightArr;
@property (nonatomic,assign) NSInteger  selectIndex;

@end

@implementation TextTabViewController

-(NSMutableArray *)rightArr{

    if (!_rightArr) {
        _rightArr = @[].mutableCopy;
    }
    return _rightArr;
    
}

-(UITableView *)rightTableView{

    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 64, kScreenWidth - self.leftTableView.width, kScreenHeight-64)];
        _rightTableView.showsVerticalScrollIndicator = FALSE;
        _rightTableView.showsHorizontalScrollIndicator = FALSE;
        _rightTableView.delegate=self;
        _rightTableView.dataSource=self;
        _rightTableView.delaysContentTouches = false;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_rightTableView];

    }
    return _rightTableView;
    
}

-(NSMutableArray *)leftArr{

    if (!_leftArr) {
        
        _leftArr = @[
                     
                     @{@"吃":@[@"吃1",@"吃2",@"吃3",@"吃4",@"吃5"]},
                     @{@"喝":@[@"喝1",@"喝2",@"喝3",@"喝4",@"喝5"]},
                     @{@"玩":@[@"玩1",@"玩2",@"玩3",@"玩4",@"玩5"]},
                     @{@"乐":@[@"乐1",@"乐2",@"乐3",@"乐4",@"乐5"]},
                     @{@"哈":@[@"哈1",@"哈2",@"哈3",@"哈4",@"哈5"]},
                     @{@"嘿":@[@"嘿1",@"嘿2",@"嘿3",@"嘿4",@"嘿5"]},
                     @{@"呵":@[@"呵1",@"呵2",@"呵3",@"呵4",@"呵5"]},
                     @{@"吃":@[@"吃1",@"吃2",@"吃3",@"吃4",@"吃5"]},
                     @{@"喝":@[@"喝1",@"喝2",@"喝3",@"喝4",@"喝5"]},
                     @{@"玩":@[@"玩1",@"玩2",@"玩3",@"玩4",@"玩5"]},
                     @{@"乐":@[@"乐1",@"乐2",@"乐3",@"乐4",@"乐5"]},
                     @{@"哈":@[@"哈1",@"哈2",@"哈3",@"哈4",@"哈5"]},
                     @{@"嘿":@[@"嘿1",@"嘿2",@"嘿3",@"嘿4",@"嘿5"]},
                     @{@"呵":@[@"呵1",@"呵2",@"呵3",@"呵4",@"呵5"]},
                     @{@"吃":@[@"吃1",@"吃2",@"吃3",@"吃4",@"吃5"]},
                     @{@"喝":@[@"喝1",@"喝2",@"喝3",@"喝4",@"喝5"]},
                     @{@"玩":@[@"玩1",@"玩2",@"玩3",@"玩4",@"玩5"]},
                     @{@"乐":@[@"乐1",@"乐2",@"乐3",@"乐4",@"乐5"]},
                     @{@"哈":@[@"哈1",@"哈2",@"哈3",@"哈4",@"哈5"]},
                     @{@"嘿":@[@"嘿1",@"嘿2",@"嘿3",@"嘿4",@"嘿5"]},
                     @{@"呵":@[@"呵1",@"呵2",@"呵3",@"呵4",@"呵5"]},
                     @{@"吃":@[@"吃1",@"吃2",@"吃3",@"吃4",@"吃5"]},
                     @{@"喝":@[@"喝1",@"喝2",@"喝3",@"喝4",@"喝5"]},
                     @{@"玩":@[@"玩1",@"玩2",@"玩3",@"玩4",@"玩5"]},
                     @{@"乐":@[@"乐1",@"乐2",@"乐3",@"乐4",@"乐5"]},
                     @{@"哈":@[@"哈1",@"哈2",@"哈3",@"哈4",@"哈5"]},
                     @{@"嘿":@[@"嘿1",@"嘿2",@"嘿3",@"嘿4",@"嘿5"]},
                     @{@"呵":@[@"呵1",@"呵2",@"呵3",@"呵4",@"呵5"]},
                     @{@"吃":@[@"吃1",@"吃2",@"吃3",@"吃4",@"吃5"]},
                     @{@"喝":@[@"喝1",@"喝2",@"喝3",@"喝4",@"喝5"]},
                     @{@"玩":@[@"玩1",@"玩2",@"玩3",@"玩4",@"玩5"]},
                     @{@"乐":@[@"乐1",@"乐2",@"乐3",@"乐4",@"乐5"]},
                     @{@"哈":@[@"哈1",@"哈2",@"哈3",@"哈4",@"哈5"]},
                     @{@"嘿":@[@"嘿1",@"嘿2",@"嘿3",@"嘿4",@"嘿5"]},
                     @{@"呵":@[@"呵1",@"呵2",@"呵3",@"呵4",@"呵5"]},


                     
                     
                     ].mutableCopy;

    }
    return _leftArr;
    
}

-(UITableView *)leftTableView{

    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth/5, kScreenHeight-64)];
        _leftTableView.showsVerticalScrollIndicator = FALSE;
        _leftTableView.showsHorizontalScrollIndicator = FALSE;
        _leftTableView.delegate=self;
        _leftTableView.dataSource=self;
        _leftTableView.delaysContentTouches = false;
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_leftTableView];
    }
    return _leftTableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftTableView];
    
    [self rightTableView];
    
    NSIndexPath * indexpatch = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftTableView selectRowAtIndexPath:indexpatch animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

#pragma mark - 设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSDictionary * dict = self.leftArr[indexPath.row];
    cell.textLabel.text = [dict allKeys][0];
    if (tableView == self.rightTableView) {
        NSDictionary * dict = self.leftArr[indexPath.section];
        NSArray * arr = [dict objectForKey:[dict allKeys][0]];
        cell.textLabel.text = arr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.rightTableView) {
        return;
    }
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark - 设置section的个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.leftTableView) {
        return 1;
    }else{
        return self.leftArr.count;
    }
}

#pragma mark - 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView) {
        return self.leftArr.count;
    }else{
        NSDictionary * dict = self.leftArr[section];
        NSArray * arr = [dict objectForKey:[dict allKeys][0]];
        return arr.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView)return nil;
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 30);
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(20, 0, 200, 30);
    lab.text = @"热门列表";
    NSDictionary * dict = self.leftArr[section];
    lab.text = [dict allKeys][0];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.font = [UIFont systemFontOfSize:13];
    [view addSubview:lab];
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0.1;
    }
    else {
        return 30;
    }
    return 0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.leftTableView) {
        return;
    }
    NSIndexPath * path =  [self.rightTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    NSIndexPath * indexpatch = [NSIndexPath indexPathForRow:path.section inSection:0];
    [self.leftTableView selectRowAtIndexPath:indexpatch animated:false scrollPosition:UITableViewScrollPositionMiddle];
    
}


@end

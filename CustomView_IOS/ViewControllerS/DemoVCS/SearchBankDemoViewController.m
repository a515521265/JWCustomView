//
//  SearchBankDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/8/30.
//
//

#import "SearchBankDemoViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"

@interface SearchBankDemoViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray  * hotBankArray;
@property (nonatomic,strong) NSMutableArray  * otherBankArray;
@property (nonatomic,strong) NSMutableArray  * searchResults;
@property (nonatomic,strong) UISearchBar *mySearchBar;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;
@end

@implementation SearchBankDemoViewController

-(NSMutableArray *)hotBankArray{
    if (!_hotBankArray) {
        _hotBankArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _hotBankArray;
}

-(NSMutableArray *)otherBankArray{
    if (!_otherBankArray) {
        _otherBankArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _otherBankArray;
}

-(NSMutableArray *)searchResults{
    if (!_searchResults) {
        _searchResults = [NSMutableArray arrayWithCapacity:10];
    }
    return _searchResults;
}

-(UISearchBar *)mySearchBar{
    
    if (!_mySearchBar) {
        _mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 40)];
        _mySearchBar.delegate = self;
        [_mySearchBar setPlaceholder:@"输入银行中文名或拼音"];
    }
    return _mySearchBar;
}


-(UISearchDisplayController *)searchDisplayController{
    
    if (!_searchDisplayController) {
        _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.mySearchBar contentsController:self];
        _searchDisplayController.active = NO;
        _searchDisplayController.searchResultsDataSource = self;
        _searchDisplayController.searchResultsDelegate = self;
    }
    return _searchDisplayController;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.delaysContentTouches = false;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableHeaderView = self.mySearchBar;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.hotBankArray = [@[@"工商银行",@"建设银行",@"招商银行",@"农业银行",@"中国银行",@"光大银行",@"兴业银行",@"广发银行",@"浦发银行",@"民生银行",@"中信银行",@"平安银行",@"华夏银行",@"广州银行"]mutableCopy];
    self.otherBankArray = [@[@"家文银行",@"佳文银行",@"梁先森银行",@"辣鸡银行",@"支付宝银行"]mutableCopy];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    }
    else {
        if (section==0) {
            return self.hotBankArray.count;
        }else{
            return self.otherBankArray.count;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 0.1;
    }
    else {
        if (section==0&&self.hotBankArray.count) {
            return 30;
        }
        else if(section==1&&self.otherBankArray.count){
            return 30;
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = self.searchResults[indexPath.row];
    }
    else {
        if (indexPath.section==0) {
            cell.textLabel.text = self.hotBankArray[indexPath.row];
        }
        else{
            cell.textLabel.text = self.otherBankArray[indexPath.row];
        }
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.searchDisplayController.searchResultsTableView)return nil;
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 30);
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(20, 0, 200, 30);
    if (section==0&&self.hotBankArray.count) {
        lab.text = @"热门银行";
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else if(section==1&&self.otherBankArray.count){
        lab.text = @"银行列表";
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    lab.font = [UIFont systemFontOfSize:13];
    [view addSubview:lab];
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DWBankModel * bankMode;
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        bankMode = self.searchResults[indexPath.row];
//    }
//    else {
//        if (indexPath.section==0) {
//            bankMode = self.hotBankArray[indexPath.row];
//        }else{
//            bankMode = self.otherBankArray[indexPath.row];
//        }
//    }
//    !self.backBankName ? : self.backBankName (bankMode);
//    [self.navigationController popViewControllerAnimated:true];
}

#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.searchResults removeAllObjects];
    
    [self.hotBankArray addObjectsFromArray:self.otherBankArray];
    
    if (self.mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:self.mySearchBar.text]) {
        for (int i=0; i<self.hotBankArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:self.hotBankArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:self.hotBankArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [self.searchResults addObject:self.hotBankArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:self.hotBankArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [self.searchResults addObject:self.hotBankArray[i]];
                }
            }
            else {
                NSRange titleResult=[self.hotBankArray[i] rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [self.searchResults addObject:self.hotBankArray[i]];
                }
            }
        }
        //过滤重复数据
        NSArray *newDataArray = self.searchResults;
        NSMutableArray *listAry = [[NSMutableArray alloc]init];
        for (NSString *str in newDataArray) {
            if (![listAry containsObject:str]) {
                [listAry addObject:str];
            }
        }
        [self.searchResults removeAllObjects];
        self.searchResults  = listAry;
        
    } else if (self.mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:self.mySearchBar.text]) {
        for (NSString * bankMode in self.hotBankArray) {
            NSRange titleResult=[bankMode rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [self.searchResults addObject:bankMode];
            }
        }
        NSArray *newDataArray = self.searchResults;
        NSMutableArray *listAry = [[NSMutableArray alloc]init];
        for (NSString *str in newDataArray) {
            if (![listAry containsObject:str]) {
                [listAry addObject:str];
            }
        }
        [self.searchResults removeAllObjects];
        self.searchResults  = listAry;
    }
}


@end

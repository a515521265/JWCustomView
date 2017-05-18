//
//  LoadGIFimageViewVC.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/18.
//
//

#import "LoadGIFimageViewVC.h"
#import "GridTableViewCell.h"

@interface LoadGIFimageViewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation LoadGIFimageViewVC

static int size = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSMutableArray * arr = @[].mutableCopy;
    
    for (int i =0; i < 11; i++) {
        NSString * str = @"load".a(i).a(@".gif");
//        if (i%2==0) {
//          str = [NSString stringWithFormat:@"load0.gif"];
//        }else{
//          str = [NSString stringWithFormat:@"load1.gif"];
//        }
        [arr addObject:str];
    }
    
    NSArray * allSubArr = [self splitArray:arr withSubSize:size];
    
    self.dataArr = [NSMutableArray arrayWithArray:allSubArr];
    
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
    GridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[GridTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.imageArr = self.dataArr[indexPath.row];
    HXWeak_self
    cell.tapindex = ^(NSString *backStr) {
        HXStrong_self
        JWAlertView * alert = [[JWAlertView alloc]initJWAlertViewWithTitle:nil message:@"您点击了".a(backStr).a(@"索引") delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert alertShow];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - 设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenWidth/size;
}
/**
 *  拆分数组
 *  @param array   需要拆分的数组
 *  @param subSize 指定长度
 *  @return 包含子数组的数组
 */
- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    return [arr copy];
}

@end

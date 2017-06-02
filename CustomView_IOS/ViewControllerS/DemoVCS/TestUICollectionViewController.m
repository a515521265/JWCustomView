//
//  TestUICollectionViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/6/2.
//
//

#import "TestUICollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionReusableView.h"

@interface TestUICollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation TestUICollectionViewController

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:10];
        _dataArr = @[@"恒",@"善",@"信",@"诚",@"梁",@"家",@"文"].mutableCopy;
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //创建布局
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init ];
    layout.itemSize = CGSizeMake(kScreenWidth/5-1, kScreenWidth/5); //item size
    layout.minimumLineSpacing = 0.5; //纵向间距
    layout.minimumInteritemSpacing = 0.5; //横向间距
    //    layout.sectionInset = UIEdgeInsetsMake(0, 0.5, 0, 0.5); //item内边距
    
    // 1.4设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //    // 1.5设置header区域大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50);
    //    // 1.6设置footer区域大小
    //    layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collectionView.alwaysBounceVertical = YES; //不够一屏也可以滚动
    [self.view addSubview:_collectionView];
    //注册cell
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    //注册header
    [_collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    //注册footer
    [_collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.dataArr = @[@"恒",@"善",@"信",@"诚",@"梁",@"家",@"文",@"恒",@"善",@"信",@"诚",@"梁",@"家",@"文",@"恒",@"善",@"信",@"诚",@"梁",@"家",@"文",@"恒",@"善",@"信",@"诚",@"梁",@"家",@"文"].mutableCopy;
        [self.collectionView reloadData];
        
    });
}

-(void)viewDidLayoutSubviews{
    
    _collectionView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    
}


#pragma mark ---- UICollectionViewDataSource
//分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//分组有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section) {
        return self.dataArr.count-3;
    }
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.labText = self.dataArr[indexPath.row];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
    
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //header
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        MyCollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[MyCollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor redColor];
        headerView.labText = [NSString stringWithFormat:@"header%ld",(long)indexPath.section];
        
        return headerView;
    }
    //footer
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        MyCollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[MyCollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        footerView.labText = [NSString stringWithFormat:@"footer%ld",(long)indexPath.section];
        return footerView;
    }
    
    return nil;
}
//header size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 20);
}

//footer size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 20);
}
//选中颜色
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didHighlightItemAtIndexPath");
    UICollectionViewCell *cell = (UICollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

//取消选中颜色
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didUnhighlightItemAtIndexPath");
    UICollectionViewCell *cell = (UICollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
}


#pragma mark
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}


//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}


@end

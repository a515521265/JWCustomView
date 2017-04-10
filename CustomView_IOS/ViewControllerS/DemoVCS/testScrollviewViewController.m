//
//  testScrollviewViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/24.
//
//

#import "testScrollviewViewController.h"
#import "JWScrollView.h"

@interface testScrollviewViewController ()
@property (nonatomic,strong) JWScrollView * scrollView;
@end

@implementation testScrollviewViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
        //        _scrollView.delaysContentTouches =false;
        _scrollView.contentSize = CGSizeMake(1000,1000);
        _scrollView.minimumZoomScale = 10;
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 1000;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    image.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

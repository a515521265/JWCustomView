//
//  WebViewDemoViewController.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "WebViewDemoViewController.h"

@interface WebViewDemoViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation WebViewDemoViewController

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        _webView.delegate=self;
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = request.URL.absoluteString;
    NSString *scheme = @"hsxc://";
    if ([url hasPrefix:scheme]) {
        NSString *path = [url substringFromIndex:scheme.length];
        //切割路径
        NSArray *subpaths = [path componentsSeparatedByString:@"?"];
        
        NSString *methodName = [[subpaths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        
        NSArray *params = nil;
        if (subpaths.count == 2) {
            params = [[subpaths lastObject] componentsSeparatedByString:@"&"];
        }
        // 调用
        [self performSelector:NSSelectorFromString(methodName) withObjects:params];
        return NO;
    }
    return YES;
}

-(void)titleStr:(NSString *)title urlStr:(NSString *)url{
    
    NSString* string4 = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"title:%@-----url:%@",string4,url);
}

-(void)closekeyboard{
    NSLog(@"%s",__func__);
}

-(void)statistical:(NSString *)statisticalStr{
    
    NSLog(@"%@---%s",statisticalStr,__func__);
}




@end

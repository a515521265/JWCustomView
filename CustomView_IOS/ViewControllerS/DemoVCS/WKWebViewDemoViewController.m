//
//  WKWebViewDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/10/31.
//
//

#import "WKWebViewDemoViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewDemoViewController () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView * wkWebView;

@property (nonatomic,strong) customHUD * hud;

@end

@implementation WKWebViewDemoViewController

-(customHUD *)hud{

    if (!_hud) {
        _hud = [[customHUD alloc]init];
    }
    return _hud;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:self.wkWebView];
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
     [self.hud showCustomHUDWithView:self.view];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
    [self.hud hideCustomHUD];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
}



//// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
//{
//    NSLog(@"%s",__func__);
//}
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSLog(@"%s",__func__);
//}
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSLog(@"%s",__func__);
//}

@end

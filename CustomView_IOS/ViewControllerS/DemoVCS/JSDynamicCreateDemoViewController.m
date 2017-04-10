//
//  JSDynamicCreateDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/10/26.
//
//

#import "JSDynamicCreateDemoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface JSDynamicCreateDemoViewController () <UIWebViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIWebView * webView;

@property (strong, nonatomic) UIImagePickerController *imagePC;

@end

@implementation JSDynamicCreateDemoViewController

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        _webView.delegate=self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"empty" withExtension:@"html"]]];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *jsStr =
    @"var newBtn = document.createElement('button');"
    "document.body.appendChild(newBtn);"
    "newBtn.onclick = function (){ location.href = 'hsxc://createbtntap' };"
    "newBtn.type.value = \"添加图片\"";
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    
}

-(void)createbtntap{
    
//    NSLog(@"---------66666");
    //图库
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if ((author == ALAuthorizationStatusRestricted) || (author == ALAuthorizationStatusDenied)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告！" message:@"当前图库不可使用,是否开启权限！" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (!_imagePC) {
        _imagePC = [UIImagePickerController new];
        _imagePC.delegate = self;
    }
    self.imagePC.mediaTypes = @[(NSString *)kUTTypeImage];//(NSString *)kUTTypeMovie
    self.imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePC animated:YES completion:nil];
    
}


//UIImagePickerController代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"%@",mediaType);
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage])
    {
        NSString * imageFile = [info objectForKey:UIImagePickerControllerReferenceURL];
        
//        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];

        
        NSString * imageStr =
        @"var newimage = document.createElement('image');"
        "document.body.appendChild(newimage);"
        "img.src='http://www.abaonet.com/img.gif'"
        "newBtn.type.value = \"添加图片\"";
        

    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end

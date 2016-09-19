//
//  NSObject+Extension.h
//  JWKit
//
//  Created by 薄睿杰 on 16/6/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/**
 *  获取该对象全部的属性
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)allPropertyDescription;

/**
 *  web交互方法
 *
 *  @param selector <#selector description#>
 *  @param objects  <#objects description#>
 *
 *  @return <#return value description#>
 */
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

/*
 
    服务器端调用OC方法：location.href = 'hsxc://titleStr_urlStr_?我擦擦擦擦擦&http://www.baidu.com';
                     location.href = 'hsxc://closekeyboard'

 
    OC拦截请求方法：
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
    OC实现拦截到的请求方法：
 - (void)titleStr:(NSString *)title urlStr:(NSString *)url{
     
     NSString* string4 = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     NSLog(@"title:%@-----url:%@",string4,url);
     }
 */


#pragma mark - KVO

/**
 *  通过Block方式注册一个KVO，通过该方式注册的KVO无需手动移除，其会在被监听对象销毁的时候自动移除,所以下面的两个移除方法一般无需使用
 *
 *  @param keyPath 监听路径
 *  @param block   KVO回调block，obj为监听对象，oldVal为旧值，newVal为新值
 */
- (void)xw_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id obj, id oldVal, id newVal))block;

/**
 *  提前移除指定KeyPath下的BlockKVO(一般无需使用，如果需要提前注销KVO才需要)
 *
 *  @param keyPath 移除路径
 */
- (void)xw_removeObserverBlockForKeyPath:(NSString *)keyPath;

/**
 *  提前移除所有的KVOBlock(一般无需使用)
 */
- (void)xw_removeAllObserverBlocks;

#pragma mark - Notification

/**
 *  通过block方式注册通知，通过该方式注册的通知无需手动移除，同样会自动移除
 *
 *  @param name  通知名
 *  @param block 通知的回调Block，notification为回调的通知对象
 */
- (void)xw_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block;

/**
 *  提前移除某一个name的通知
 *
 *  @param name 需要移除的通知名
 */
- (void)xw_removeNotificationForName:(NSString *)name;

/**
 *  提前移除所有通知
 */
- (void)xw_removeAllNotification;

/**
 *  发送一个通知
 *
 *  @param name     通知名
 *  @param userInfo 数据字典
 */
- (void)xw_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo;



@end

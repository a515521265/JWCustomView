//
//  XLNotificationTransfer.m
//  通知
//
//  Created by 田馥甄 on 2016/11/9.
//  Copyright © 2016年 hebe. All rights reserved.
//

#import "XLNotificationTransfer.h"
#import "XLRuntime.h"

/**
 *   调用代码块
 *   block  代码块
 *   ...    自定义个数的参数
 */
#define XLCALL(block,...) \
XLCALLRETURN(block,nil,__VA_ARGS__)

/**
 *   调用代码块，并且有返回值
 *   block  代码块
 *   value  代码块不存在时的返回值
 *   ...    自定义个数的参数
 */
#define XLCALLRETURN(block,value,...) \
!block?value:block(__VA_ARGS__)



@interface NSNotificationCenter (_XLNotificationTransferSupports)

@property (nonatomic, strong) NSMapTable *notifications;

@end

@implementation NSNotificationCenter (_XLNotificationTransferSupports)

+ (void)load {
    XLMethodSwizzling(defaultCenter)
}

+ (NSNotificationCenter *)__XL_defaultCenter {
    NSNotificationCenter *center = [self __XL_defaultCenter];
    if (!center.notifications) {
        center.notifications = [NSMapTable weakToWeakObjectsMapTable];
    }
    return center;
}

XLCategoryProperty_id(setNotifications, notifications)

@end

@implementation XLNotificationTransfer

static NSString * const XLNotificationTransferData = @"XLNTData";

+ (void)post_name:(NSString *)name userInfo:(id)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:@{XLNotificationTransferData:userInfo}];
}

+ (void)observer_name:(NSString *)name callback:(void (^)(id))callback {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center.notifications setObject:[center addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        id userInfo = note.userInfo;
        if (userInfo[XLNotificationTransferData]) {
            userInfo = userInfo[XLNotificationTransferData];
        }
        XLCALL(callback,userInfo);
    }] forKey:name];
}

+ (void)remove_name:(NSString *)name {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:[center.notifications objectForKey:name]];
}


@end

@implementation NSString (_XLNotificationTransferSupports)

- (void)postNotification_userInfo:(id)userInfo {
    [XLNotificationTransfer post_name:self userInfo:userInfo];
}

- (void)addObserver_callback:(void (^)(id))callback {
    [XLNotificationTransfer observer_name:self callback:callback];
}

- (void)removeObserver {
    [XLNotificationTransfer remove_name:self];
}

@end

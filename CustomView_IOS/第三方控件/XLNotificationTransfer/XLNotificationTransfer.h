//
//  XLNotificationTransfer.h
//  通知
//
//  Created by 田馥甄 on 2016/11/9.
//  Copyright © 2016年 hebe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLNotificationTransfer : NSObject

@end


@interface NSString (_XLNotificationTransferSupports)

- (void)postNotification_userInfo:(id)userInfo;

- (void)addObserver_callback:(void (^)(id obj))callback;

- (void)removeObserver;

@end

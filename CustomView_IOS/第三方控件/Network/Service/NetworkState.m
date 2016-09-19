//
//  NetworkState.m
//  handheldCredit
//
//  Created by 李贵文 on 16/1/16.
//  Copyright © 2016年 liguiwen. All rights reserved.
//

#import "NetworkState.h"

@implementation NetworkState
+ (void)WithSuccessBlock:(successBlock)success {
    [[self sharedManager] startMonitoring];
    [[self sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            success(false);
        }else if (status == 1){
            success(true);
        }else if (status == 2){
            success(true);
        }
    }];
}
@end

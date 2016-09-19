//
//  NetworkState.h
//  handheldCredit
//
//  Created by 李贵文 on 16/1/16.
//  Copyright © 2016年 liguiwen. All rights reserved.
//

#import "AFNetworkReachabilityManager.h"
#import "AFNetworking.h"
typedef void (^successBlock)(BOOL status);
@interface NetworkState : AFNetworkReachabilityManager
+ (void)WithSuccessBlock:(successBlock)success;
@end

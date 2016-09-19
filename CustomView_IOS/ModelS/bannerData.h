//
//  bannerData.h
//  handheldCredit
//
//  Created by joke on 15/12/28.
//  Copyright © 2015年 liguiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bannerData : NSObject
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * imageurl;
@property (strong, nonatomic) NSString * link;
@property (assign, nonatomic) long long createTime;

@end

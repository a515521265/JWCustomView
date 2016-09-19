//
//  bannerData.m
//  handheldCredit
//
//  Created by joke on 15/12/28.
//  Copyright © 2015年 liguiwen. All rights reserved.
//

#import "bannerData.h"

@implementation bannerData
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"bannerDataModel undefinedKey:%@",key);
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"title"]) {
        self.title = [value isEqual:[NSNull null]] ? nil : value;
    }else if ([key isEqualToString:@"imageurl"]) {
        self.imageurl = [value isEqual:[NSNull null]] ? nil : value;
    }else if ([key isEqualToString:@"link"]) {
        self.link = [value isEqual:[NSNull null]] ? nil : value;
    } else if ([key isEqualToString:@"createTime"]) {
        self.createTime = [value isEqual:[NSNull null]] ? 0 : [value longLongValue];
    }
}
@end
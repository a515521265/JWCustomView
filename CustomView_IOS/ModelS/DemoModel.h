//
//  DemoModel.h
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoModel : NSObject

@property (nonatomic,strong) NSString * className;

@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) NSString * demoDescribe;

+ (instancetype)itemWithDcit:(NSDictionary *)dict;

@end

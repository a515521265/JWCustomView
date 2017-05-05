//
//  TextModel.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/5.
//
//

#import "TextModel.h"

@implementation TextModel

+ (instancetype)itemWithDcit:(NSDictionary *)dict{
    
    TextModel *model = [[[self class] alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}


@end

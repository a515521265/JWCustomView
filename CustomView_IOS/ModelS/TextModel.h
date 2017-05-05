//
//  TextModel.h
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/5.
//
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject

@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) NSArray * contentS;

@property (nonatomic,assign) BOOL isShow;

+ (instancetype)itemWithDcit:(NSDictionary *)dict;

@end

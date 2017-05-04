//
//  HXBaseModel.h
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/4.
//
//

#import <Foundation/Foundation.h>

@interface HXBaseModel : NSObject

/**
 *  可以alloc init后生成model  再set数据
 *
 *  @param dict 数据
 */
- (void)setDict:(NSDictionary *)dict;


/**
 *  也可以直接生成model
 *
 *  @param dict 数据
 */
+ (instancetype )objectWithDict:(NSDictionary *)dict;



// 告诉数组中都是什么类型的模型对象 子类中需要重写;
- (NSDictionary *)objectClassInArray ;

@end

//
//  HXBaseModel.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/4.
//
//

#import "HXBaseModel.h"
#import <objc/runtime.h>
@implementation HXBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dataInit];
    }
    return self;
}

/**
 *  数据初始化赋值  防止出现“null”等
 */
- (void)dataInit
{
    Class classSelf = self.class;
    while (classSelf && classSelf != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(classSelf, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //实例变量名转为属性名（其实就是去掉下划线 _ ）
            key = [key substringFromIndex:1];
            
            //直接初始化为@0（给int bool float double long等类型赋初始值）
            id value = @0;
            
            //获得成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            //如果属性是对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                //截取对象的类型名字
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                
                if ([type isEqualToString:@"NSString"]) {
                    value = @"";
                }
                if ([type isEqualToString:@"NSNumber"]) {
                    value = @0;
                }
                
                //排除系统的对象类型（其实就是字典转化成的自定义模型）
                if (![type hasPrefix:@"NS"]) {
                    
                    Class class = NSClassFromString(type);
                    //因为此模型一定是继承的本Model（HSJsonModel） 所以初始化时 一定会按此方法的规则 对其每个属性 设置初始值
                    value = [[class alloc]init];
                    
                    //若是数组 初始化为 空数组
                }else if ([type isEqualToString:@"NSArray"]) {
                    
                    value = @[];
                }else if ([type isEqualToString:@"NSMutableArray"]){
                    value = [NSMutableArray array];
                }
            }
            
            //将初始化的值设置到模型上
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        classSelf = [classSelf superclass];
    }
}

- (void)setDict:(NSDictionary *)dict {
    
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 成员变量名转为属性名（去掉下划线 _ ）
            key = [key substringFromIndex:1];
            
            if (!dict[key] || [dict[key] isKindOfClass:[NSNull class]]) {
                continue;
            }
            // 取出字典的值
            id value = dict[key];
            
            // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
            if (value == nil) continue;
            
            // 获得成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            // 如果属性是对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                // 那么截取对象的名字（比如@"Dog"，截取为Dog）
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                // 排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                    // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class class = NSClassFromString(type);
                    value = [class objectWithDict:value];
                    
                }else if ([type isEqualToString:@"NSArray"] || [type isEqualToString:@"NSMutableArray"]) {
                    
                    
                    // 如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                    NSMutableArray *array = [(NSArray *)value mutableCopy];
                    NSMutableArray *mArray = [NSMutableArray array];
                    
                    if ([self respondsToSelector:@selector(objectClassInArray)]) {
                        
                        id class ;
                        // 获取到每个模型的类型
                        
                        if ([[self objectClassInArray] objectForKey:key]) {
                            if (![[[self objectClassInArray] objectForKey:key] isKindOfClass:[NSNull class]]) {
                                class = [[self objectClassInArray] objectForKey:key];
                                
                                for (int i = 0; i < array.count; i++) {
                                    [mArray addObject:[class objectWithDict:value[i]]];
                                }
                                value = mArray;
                                
                            }else{
                                value = array;
                                NSLog(@"--【%@】--#warning:没有检测到以%@命名的数组内元素相匹配的数据类型", NSStringFromClass(c), key);
                            }
                        }else{
                            value = array;
                            NSLog(@"--【%@】--#warning:没有检测到以%@命名的数组内元素相匹配的数据类型", NSStringFromClass(c), key);
                        }
                    }else{
                        value = array;
                    }
                }
            }
            
            // 将字典中的值设置到模型上
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        c = [c superclass];
    }
}

// 告诉数组中都是什么类型的模型对象
- (NSDictionary *)objectClassInArray
{
    return @{};
}

+ (instancetype )objectWithDict:(NSDictionary *)dict {
    HXBaseModel *obj = [[self alloc]init];
    [obj setDict:dict];
    return obj;
}


@end

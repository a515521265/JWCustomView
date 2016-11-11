//
//  UIImage+ColorImage.m
//  coreEnterpriseDW
//
//  Created by 栾美娜 on 16/5/27.
//  Copyright © 2016年 Nathaniel. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

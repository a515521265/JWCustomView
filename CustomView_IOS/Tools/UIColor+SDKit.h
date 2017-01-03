//
//  UIColor+SDKit.h
//  SDKit
//
//  Created by NSLog on 16/4/25.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SDRGBA(r, g, b, a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define SDRGB(r, g, b)     [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

/*
 * 给UIColor添加很多有用的方法
 */
@interface UIColor (SDKit)

/*
 * 返回当前颜色的r值
 */
- (CGFloat)redValue;

/*
 * 返回当前颜色的g值
 */
- (CGFloat)greenValue;

/*
 * 返回当前颜色的b值
 */
- (CGFloat)blueValue;

/*
 * 打印查看当前颜色的rgba值
 */
- (void)colorDetail;

/*
 * 传入一个十六进制颜色字符串，转换为相应的颜色。（不带"#"号）
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexString;

/*
 *  烟白色(F5F5F5)
 */
+ (UIColor *)smokeWhiteColor;

/*
 *  黄绿色(9ACD32)
 */
+ (UIColor *)yellowGreenColor;

/*
 *  艾利斯兰(F0F8FF)
 */
+ (UIColor *)aliceBlueColor;

/*
 *  古董白(FAEBD7)
 */
+ (UIColor *)antiqueWhiteColor;

/*
 *  碧绿色(7FFFD4)
 */
+ (UIColor *)aquaMarineColor;

/*
 *  米色(F5F5DC)
 */
+ (UIColor *)beigeColor;

/*
 *  紫罗兰色(8A2BE2)
 */
+ (UIColor *)blueVioletColor;

/*
 *  实木色(DEB887)
 */
+ (UIColor *)burlyWoodColor;

@end

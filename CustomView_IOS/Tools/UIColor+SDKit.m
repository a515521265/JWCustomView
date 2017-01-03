//
//  UIColor+SDKit.m
//  SDKit
//
//  Created by NSLog on 16/4/25.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import "UIColor+SDKit.h"

@implementation UIColor (SDKit)

- (CGFloat)redValue
{
    const CGFloat *compont = CGColorGetComponents(self.CGColor);
    return compont[0];
}

- (CGFloat)greenValue
{
    const CGFloat *compont = CGColorGetComponents(self.CGColor);
    return compont[1];
}

- (CGFloat)blueValue
{
    const CGFloat *compont = CGColorGetComponents(self.CGColor);
    return compont[2];
}

- (void)colorDetail
{
    
}

+ (UIColor *)colorWithHexColorString:(NSString *)hexString
{
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringWithRange:NSMakeRange(1, hexString.length - 1)];
    }
    const char *redChar = [[hexString substringWithRange:NSMakeRange(0, 2)] UTF8String];
    const char *greenChar = [[hexString substringWithRange:NSMakeRange(2, 2)] UTF8String];
    const char *blueChar = [[hexString substringWithRange:NSMakeRange(4, 2)] UTF8String];

    return SDRGB(strtoul(redChar, 0, 16), strtoul(greenChar, 0, 16), strtoul(blueChar, 0, 16));
}

+ (UIColor *)smokeWhiteColor
{
    return [self colorWithHexColorString:@"F5F5F5"];
}

+ (UIColor *)yellowGreenColor
{
    return [self colorWithHexColorString:@"9ACD32"];
}

+ (UIColor *)aliceBlueColor
{
    return [self colorWithHexColorString:@"F0F8FF"];
}

+ (UIColor *)antiqueWhiteColor
{
    return [self colorWithHexColorString:@"FAEBD7"];
}

+ (UIColor *)aquaMarineColor
{
    return [self colorWithHexColorString:@"7FFFD4"];
}

+ (UIColor *)beigeColor
{
    return [self colorWithHexColorString:@"F5F5DC"];
}

+ (UIColor *)blueVioletColor
{
    return [self colorWithHexColorString:@"8A2BE2"];
}

+ (UIColor *)burlyWoodColor
{
    return [self colorWithHexColorString:@"DEB887"];
}
@end

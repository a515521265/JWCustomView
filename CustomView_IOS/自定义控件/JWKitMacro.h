//
//  JWKitMacro.h
//  JWKit
//
//  Created by 薄睿杰 on 16/6/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#ifndef JWKitMacro_h
#define JWKitMacro_h

#define kScreenFrame    [UIScreen mainScreen].bounds
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define HXWeak_(arg) \
__weak typeof(arg) weak_##arg = arg;
#define HXStrong_(arg) \
__strong typeof(weak_##arg) arg = weak_##arg;

#define HXWeak_self \
HXWeak_(self)
#define HXStrong_self \
HXStrong_(self)

// 字体相关创建器，包括动态字体的支持
#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#define UIFontBoldWithFont(_font) [UIFont boldSystemFontOfSize:_font.pointSize]


#endif /* JWKitMacro_h */

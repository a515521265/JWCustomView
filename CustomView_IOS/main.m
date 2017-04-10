//
//  main.m
//  项目控件集合
//
//  Created by 恒善信诚科技有限公司 on 16/8/25.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <JSPatchPlatform/JSPatch.h>

//#include "HelloWorld.java"

int main(int argc, char * argv[]) {
    
    
    @autoreleasepool {
        
        [JPEngine startEngine];
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"JWDemo" ofType:@"js"];
        NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
        [JPEngine evaluateScript:script];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        
    }
}

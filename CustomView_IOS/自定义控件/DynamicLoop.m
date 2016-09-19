//
//  DynamicLoop.m
//  songShuFinance
//
//  Created by 梁家文 on 15/12/16.
//  Copyright © 2015年 李贵文. All rights reserved.
//

#import "DynamicLoop.h"
#import "JWKitMacro.h"
#import "YYWeakProxy.h"
@interface DynamicLoop ()
@property (nonatomic ,assign)CGFloat t;
@end


@implementation DynamicLoop

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.center radius:100.0 startAngle:0.0 endAngle:180.0 clockwise:YES];
    //绘制前加入描边颜色
    [[UIColor redColor] setStroke];
    [path setLineWidth:4];
    [path setLineCapStyle:kCGLineCapButt];
    [path stroke];
    [path addClip];
    
    CGPoint zero = CGPointMake(0, self.bounds.size.height * (1-_value));
    UIBezierPath *wave = [UIBezierPath bezierPath];
    [wave moveToPoint:zero];
    for (int i = 0; i < self.bounds.size.width; i++) {
        CGPoint p = relativeCoor(zero, i, 3*sin(M_PI /50 *i + _t ) );
        [wave addLineToPoint:p];
    }
    [wave addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [wave addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [_color set];
    [wave fill];
}

-(void)didMoveToSuperview{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(change) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)change{
    _t += M_PI * 0.02;
    if (_t == M_PI * 2) {
        _t = 0;
    }
    [self setNeedsDisplay];
}

CGPoint relativeCoor(CGPoint point, CGFloat x ,CGFloat y){
    return CGPointMake(point.x + x, point.y + y);
}
@end

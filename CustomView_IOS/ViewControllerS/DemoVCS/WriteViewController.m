//
//  WriteViewController.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/26.
//
//


#import "WriteViewController.h"

#import <CoreText/CoreText.h>

@interface WriteViewController ()

@property (nonatomic,strong) UIView * displayView;

@property (nonatomic,strong) JWTextField * textF;

@property (nonatomic,strong) UIButton * button;

@end

@implementation WriteViewController

static NSInteger fontSize  = 30;

-(UIView *)displayView{

    if (!_displayView) {
        _displayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.button.frame)+20, kScreenWidth, kScreenWidth)];
//        _displayView.bgColor([UIColor redColor]);
        [self.view addSubview:_displayView];
    }
    return _displayView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textF = [[JWTextField alloc]initWithFrame:CGRectMake(20, 80, kScreenWidth-40, 50)];
    self.textF.text = NSStringFromClass(self.class);
    [self.view addSubview:self.textF];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(20, CGRectGetMaxY(self.textF.frame), kScreenWidth-40, 30);
    [self.button setTitle:@"画图" forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor blueColor]];
    [self.button setTintColor:[UIColor whiteColor]];
    HXWeak_self
    [self.button addSingleTapEvent:^{
        HXStrong_self
        [self star];
    }];
    [self.view addSubview:self.button];
    
    [self displayView];
    
    
}

-(void)star{

    [self.displayView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    if (self.textF.text.length > 0) {
        UIBezierPath *bezierPath = [self transformToBezierPath:self.textF.text];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.bounds = CGPathGetBoundingBox(bezierPath.CGPath);
        layer.position = CGPointMake(self.view.bounds.size.width/2, 50);
        layer.geometryFlipped = YES;
        layer.path = bezierPath.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = 1;
        layer.strokeColor = [UIColor blackColor].CGColor;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0);
        animation.toValue = @(1);
        animation.duration = layer.bounds.size.width/20;
        [layer addAnimation:animation forKey:nil];
        [self.displayView.layer addSublayer:layer];
        
        
        UIImage *penImage = [UIImage imageNamed:@"pencil.png"];
        CALayer *penLayer = [CALayer layer];
        penLayer.contents = (id)penImage.CGImage;
        penLayer.anchorPoint = CGPointZero;
        penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
        [layer addSublayer:penLayer];
        
        CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        penAnimation.duration = animation.duration;
        penAnimation.path = layer.path;
        penAnimation.calculationMode = kCAAnimationPaced;
        penAnimation.removedOnCompletion = NO;
        penAnimation.fillMode = kCAFillModeForwards;
        [penLayer addAnimation:penAnimation forKey:@"position"];
        
        [penLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:penAnimation.duration+.2];
    }

    
}

- (UIBezierPath *)transformToBezierPath:(NSString *)string
{
    CGMutablePathRef paths = CGPathCreateMutable();
    CFStringRef fontNameRef = CFSTR("SnellRoundhand");
    CTFontRef fontRef = CTFontCreateWithName(fontNameRef, fontSize, nil);
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{(__bridge NSString *)kCTFontAttributeName: (__bridge UIFont *)fontRef}];
    CTLineRef lineRef = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArrRef = CTLineGetGlyphRuns(lineRef);
    
    for (int runIndex = 0; runIndex < CFArrayGetCount(runArrRef); runIndex++) {
        const void *run = CFArrayGetValueAtIndex(runArrRef, runIndex);
        CTRunRef runb = (CTRunRef)run;
        
        const void *CTFontName = kCTFontAttributeName;
        
        const void *runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb), CTFontName);
        CTFontRef runFontS = (CTFontRef)runFontC;
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        int temp = 0;
        CGFloat offset = .0;
        
        for (int i = 0; i < CTRunGetGlyphCount(runb); i++) {
            CFRange range = CFRangeMake(i, 1);
            CGGlyph glyph = 0;
            CTRunGetGlyphs(runb, range, &glyph);
            CGPoint position = CGPointZero;
            CTRunGetPositions(runb, range, &position);
            
            CGFloat temp3 = position.x;
            int temp2 = (int)temp3/width;
            CGFloat temp1 = 0;
            
            if (temp2 > temp1) {
                temp = temp2;
                offset = position.x - (CGFloat)temp;
            }
            
            CGPathRef path = CTFontCreatePathForGlyph(runFontS, glyph, nil);
            CGFloat x = position.x - (CGFloat)temp*width - offset;
            CGFloat y = position.y - (CGFloat)temp * 80;
            CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
            CGPathAddPath(paths, &transform, path);
            
            CGPathRelease(path);
        }
        CFRelease(runb);
        CFRelease(runFontS);
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    
    CGPathRelease(paths);
    CFRelease(fontNameRef);
    CFRelease(fontRef);
    
    return bezierPath;
}

@end

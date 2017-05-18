//
//  GridTableViewCell.m
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/17.
//
//

#import "GridTableViewCell.h"
#import "JWKitMacro.h"
#import "JWLabel.h"
#import "UIView+Extension.h"
#import "QRCodeGenerator.h"
#import "NerdyUI.h"
#import "UIImage+instask.h"
#import "YYAnimatedImageView.h"
#import "YYImage.h"

static int sizes = 3;

@implementation GridTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
    
}

-(void)setModels:(NSArray *)models{

    _models = models;
    
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }

    for (int i = 0; i<models.count; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(i*kScreenWidth/sizes, 0, kScreenWidth/sizes, kScreenWidth/sizes)];
//        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//        [self setviewcolor:view];
        
        UIImageView * qrImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        UIImage *img = [QRCodeGenerator qrImageForString:[self getChars] imageSize:1000 Topimg:nil withColor:[UIColor blackColor]];
        
        UIColor *topleftColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        UIColor *bottomrightColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        UIImage *bgImg = [img gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUprightToLowleft imgSize:img.size];
        UIColor *color = [UIColor colorWithPatternImage:bgImg];
        qrImageV.image =[img rt_tintedImageWithColor:color];
        [view addSubview:qrImageV];
        
        JWLabel * lab = [[JWLabel alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        lab.text = models[i];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = 1;
        lab.backgroundColor = [UIColor clearColor];
        [view addSubview:lab];
        HXWeak_self
        HXWeak_(lab)
        [lab addSingleTapEvent:^{
           HXStrong_self
            HXStrong_(lab)
            !self.tapindex ? : self.tapindex(lab.text);
        }];
        
        [self addSubview:view];
    }
    
}

-(void)setviewcolor:(UIView *)view{

    [UIView animateWithDuration:0.5 animations:^{
        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    
}


-(void)setImageArr:(NSArray *)imageArr{

    _imageArr = imageArr;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i<imageArr.count; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(i*kScreenWidth/sizes, 0, kScreenWidth/sizes, kScreenWidth/sizes)];
        
        YYAnimatedImageView * qrImageV = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];

        YYImage* image = [YYImage imageNamed:imageArr[i]];
        
        qrImageV.image = image;
        [view addSubview:qrImageV];
        [self addSubview:view];
    }
    
}

//生成随机字符串
- (NSString *)getChars
{
    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:11];
    NSMutableString *Str = [[NSMutableString alloc] initWithCapacity:11];
    
    NSMutableString  *changeString = [[NSMutableString alloc] initWithCapacity:12];
    NSMutableString *codeString = [[NSMutableString alloc] initWithCapacity:12];
    for(NSInteger i = 0; i < 10; i++)
    {
        NSInteger index = arc4random() % ([changeArray count] - 1);
        getStr = [changeArray objectAtIndex:index];
        char c = [getStr characterAtIndex:0];
        
        if (isupper(c) ) {
            //                    NSLog(@"getStr1 = %@",getStr);
            c = c+'a'-'A';
            Str = [NSMutableString stringWithFormat:@"%c",c];
        }else{
            //                    NSLog(@"getStr2 = %@",getStr);
            Str = [NSMutableString stringWithFormat:@"%c",c];
        }
        
        codeString = (NSMutableString *)[codeString stringByAppendingString:Str];
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr];
    }
    //    NSLog(@"changeString = %@",changeString);
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f",a];//转为字符型
    NSString *timeString1 = [timeString substringToIndex:(timeString.length-7)];
    
    NSString *sessionIdStr = [NSString stringWithFormat:@"%@%@",changeString,timeString1];
    return sessionIdStr;
}


@end

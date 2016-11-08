//
//  JWTextView.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/7.
//
//

#import "JWTextView.h"

@interface JWTextView () <UITextViewDelegate>

@property (nonatomic,assign)BOOL isDian;//是否有小数点
@property (nonatomic, strong) NSString *tempText;
@property (nonatomic, assign) NSRange tempRange;
@property (nonatomic, strong) NSString *tempString;
@property (nonatomic, strong) NSString *max; // 默认999999999.99

@end

@implementation JWTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.font = [UIFont systemFontOfSize:12];
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.max = @"999999999.99";
        self.maxlength = 10;
    }
    return self;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (self.importStyle == TextViewImportStyleNormal) {
        
    }else if (self.importStyle == TextViewImportStyleNumber){
        return [self validateNumber:textView.text Range:range replacementString:text];
    }else if (self.importStyle == TextViewImportStylePassword){
        
    }else if (self.importStyle == TextViewImportStyleMoney){
        return [self validateMoney:textView Range:range replacementString:text];
    }else if (self.importStyle == TextViewImportStyleMinMoney){
        return [self validateMinMoney:textView Range:range replacementString:text];
    }else if (self.importStyle == TextViewImportStyleRightfulMoney){
        return [self validateRightfulMoney:textView Range:range replacementString:text];
    }else if (self.importStyle == TextViewImportStyleNumberTwo){
        return [self validateNumberTwo:textView.text Range:range replacementString:text];
    }else if (self.importStyle == TextViewImportStyleProhibitImport){
        return false;
    }else if (self.importStyle == TextViewImportStyleChina){
        return [self validateChina:textView Range:range replacementString:text];
    }
    else{
        
    }
    !self.importBackString ? : self.importBackString (toBeString);
    return true;
}


- (void)textViewDidChange:(UITextView *)textView
{
    
    if (self.importStyle == TextViewImportStyleChina) {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
        
        //如果在变化中是高亮部分在变，就不要计算字符了
        if (selectedRange && pos) {
            return;
        }
        
        NSString  *nsTextContent = textView.text;
        NSInteger existTextNum = nsTextContent.length;
        
        if (existTextNum > self.maxlength)
        {
            //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
            NSString *s = [nsTextContent substringToIndex:self.maxlength];
            
            [textView setText:s];
        }
        [self refreshTextViewSize:textView];
    }
}


//中文输入
- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;
{
    
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    !self.backHeight ? : self.backHeight (adjustedSize.height);
    return adjustedSize;
}

- (void)refreshTextViewSize:(UITextView *)textView
{
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    CGRect frame = textView.frame;
    frame.size.height = size.height;
    !self.backHeight ? : self.backHeight (size.height);
    textView.frame = frame;
}

//其他限制


- (BOOL)validateChina:(UITextView *)textView  Range:(NSRange)range replacementString:(NSString *)text{

    
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    //对于退格删除键开放限制
    if (text.length == 0) {
        !self.importBackString ? : self.importBackString (toBeString);
        return YES;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < self.maxlength) {
            !self.importBackString ? : self.importBackString (toBeString);
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = self.maxlength - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        //加入动态计算高度
        CGSize size = [self getStringRectInTextView:comcatstr InTextView:textView];
        CGRect frame = textView.frame;
        frame.size.height = size.height;
        
        textView.frame = frame;
        !self.importBackString ? : self.importBackString (toBeString);
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          NSInteger steplen = substring.length;
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx = idx + steplen;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            
            //由于后面反回的是NO不触发didchange
            [self refreshTextViewSize:textView];
        }
        return NO;
    }

}



/**TextFieldImportStyleNumberTwo
 *  整数限制，首位不可以为0
 */
- (BOOL)validateNumber:(NSString*)number  Range:(NSRange)range replacementString:(NSString *)string {
    NSString *toBeString = [number stringByReplacingCharactersInRange:range withString:string];
    NSCharacterSet * characterSet;
    characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    if (canChange == 0) {
        return canChange;
    }
    if (toBeString.length > self.maxlength) {
        return NO;
    }
    if (toBeString.length == 1) {//第一位不能为0
        if ([filtered isEqualToString:@"0"]) {
            return NO;
        }
    }
    !self.importBackString ? : self.importBackString (toBeString);
    return true;
}
/**
 *  整数限制，首位可以为0
 */
- (BOOL)validateNumberTwo:(NSString*)number  Range:(NSRange)range replacementString:(NSString *)string {
    NSString *toBeString = [number stringByReplacingCharactersInRange:range withString:string];
    NSCharacterSet * characterSet;
    characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    if (canChange == 0) {
        return canChange;
    }
    if (toBeString.length > self.maxlength) {
        return NO;
    }
    !self.importBackString ? : self.importBackString (toBeString);
    return true;
}
/**
 *  限制金钱输入格式  (输入格式：最低输入1.00)
 */
-(BOOL)validateMoney:(UITextView *)money Range:(NSRange)range replacementString:(NSString *)string{
    
    NSString *toBeString = [money.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([money.text rangeOfString:@"."].location == NSNotFound) {
        self.isDian = NO;
    }
    if ([string length] > 0) {
        
        if (toBeString.length > self.maxlength) {
            return NO;
        }
        unichar single = [string characterAtIndex:0];
        if ((single >= '0' && single <= '9') || single == '.') {
            if([money.text length] == 0){
                if(single == '.') {
                    [money.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                if (single == '0') {
                    [money.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single == '.') {
                if(!self.isDian)
                {
                    self.isDian = YES;
                    !self.importBackString ? : self.importBackString (toBeString);
                    return YES;
                    
                }else{
                    [money.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (self.isDian) {
                    NSRange ran = [money.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        !self.importBackString ? : self.importBackString (toBeString);
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    !self.importBackString ? : self.importBackString (toBeString);
                    return YES;
                }
            }
        }else{
            [money.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else{
        !self.importBackString ? : self.importBackString (toBeString);
        return YES;
    }
}
/**
 *  限制金钱输入格式  (输入格式：最低输入0.00)
 */
-(BOOL)validateMinMoney:(UITextView *)money Range:(NSRange)range replacementString:(NSString *)string{
    
    NSString *toBeString = [money.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([money.text rangeOfString:@"."].location == NSNotFound) {
        self.isDian = NO;
    }
    if ([string length] > 0) {
        
        if (toBeString.length > self.maxlength) {
            return NO;
        }
        unichar single = [string characterAtIndex:0];
        if ((single >= '0' && single <= '9') || single == '.') {
            if([money.text length] == 0){
                if(single == '.') {
                    [money.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single == '.') {
                if(!self.isDian)
                {
                    self.isDian = YES;
                    !self.importBackString ? : self.importBackString (toBeString);
                    return YES;
                    
                }else{
                    [money.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (self.isDian) {
                    NSRange ran = [money.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        !self.importBackString ? : self.importBackString (toBeString);
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    !self.importBackString ? : self.importBackString (toBeString);
                    return YES;
                }
            }
        }else{
            [money.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else{
        !self.importBackString ? : self.importBackString (toBeString);
        return YES;
    }
}
/**
 *  合法的小数金额限制
 */
-(BOOL)validateRightfulMoney:(UITextView *)money Range:(NSRange)range replacementString:(NSString *)string{
    
    NSString *toBeString = [money.text stringByReplacingCharactersInRange:range withString:string];
    
    _tempText = money.text;
    _tempRange = range;
    _tempString = string;
    
    if (string && string.length > 0) {
        // 输入
        if (_tempText.length == 0) {
            if ([string isEqualToString:@"."]) {
                _tempText = @"0";
                !self.importBackString ? : self.importBackString (toBeString);
                return YES;
            }else{
                !self.importBackString ? : self.importBackString (toBeString);
                return YES;
            }
            
        }else if (_tempText.length == 1){
            if ([_tempText isEqualToString:@"0"]) {
                if ([string isEqualToString:@"."]) {
                    !self.importBackString ? : self.importBackString (toBeString);
                    return YES;
                }else{
                    return NO;
                }
            }
        }
        // 输入后不可超过 '99999.99'
        if ([_tempText stringByAppendingString:string].floatValue > [_max floatValue]) {
            return NO;
        }
        // 不可超过8位
        if (_tempText.length >= _max.length) {
            return NO;
        }
        
        NSRange docRange = [_tempText rangeOfString:@"."];
        if (docRange.location != NSNotFound) {
            // 已输入小数点, 禁止再输入小数点
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            // 小数点后位数
            NSUInteger decimals = _tempText.length - (docRange.location + docRange.length);
            if (decimals == 2) {
                // 小数点后两位,禁止输入任何字符
                return NO;
            }else if (decimals == 1){
                // 小数点后一位,禁止输入 '0'
                if ([string isEqualToString:@"0"]) {
                    return NO;
                }
            }
        }else{
            if (_tempText.length == 0) {
                // 第一位
                if ([string isEqualToString:@"."] || [string isEqualToString:@"0"]) {
                    return NO;
                }
            }
        }
    }
    !self.importBackString ? : self.importBackString (toBeString);
    return YES;
}

-(void)drawRect:(CGRect)rect{
    if (self.zoomText) {
        int font = (self.bounds.size.width / (self.text.length * 0.8));
        self.font = [UIFont systemFontOfSize:font > 13 ? 13 : font];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    
    NSString * selectorName = NSStringFromSelector(aSelector);
    if ([selectorName isEqualToString:@"customOverlayContainer"]) {
        NSLog(@"preventing self.delegate == self crash");
        return NO;
    }
    return [super respondsToSelector:aSelector];
    
}


@end

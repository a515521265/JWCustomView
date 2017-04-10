//
//  TextViewDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/7.
//
//

#import "TextViewDemoViewController.h"
#import "JWTextView.h"

@interface TextViewDemoViewController () <UITextViewDelegate>

@property (nonatomic,strong) UITextView * textView;

@end

@implementation TextViewDemoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(30, 200, CGRectGetWidth([[UIScreen mainScreen] bounds])-60, 30)];
    [self.textView setTextColor:[UIColor redColor]];
    [self.textView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.textView setFont:[UIFont systemFontOfSize:15]];
    self.textView.delegate = self;
    [self.textView.layer setBorderWidth:1.0f];
    [self.view addSubview:self.textView];
    
    
    JWTextView * textview1 = [[JWTextView alloc]initWithFrame:CGRectMake(30, 300, CGRectGetWidth([[UIScreen mainScreen] bounds])-60, 30)];
    textview1.backgroundColor = [UIColor redColor];
    [self.view addSubview:textview1];
    
    
    [self addNotification];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 250, 100, 30);
    [button addTarget:self action:@selector(gettext) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"gettext" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
}

-(void)gettext{

    NSLog(@"%@",self.textView.text);
    
}

//最大字符限制
static CGFloat MAX_LIMIT_NUMS = 140;


- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;
{
    //实际textView显示时我们设定的宽
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
    return adjustedSize;
}

- (void)refreshTextViewSize:(UITextView *)textView
{
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    CGRect frame = textView.frame;
    frame.size.height = size.height;
    textView.frame = frame;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //对于退格删除键开放限制
    if (text.length == 0) {
//        NSLog(@"length-----%lu",(unsigned long)text);
        NSLog(@"text----%@",text);
        return YES;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];

    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            
//            NSLog(@"length-----%lu",(unsigned long)text);
            NSLog(@"text----%@",text);
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];

    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        //加入动态计算高度
        CGSize size = [self getStringRectInTextView:comcatstr InTextView:textView];
        CGRect frame = textView.frame;
        frame.size.height = size.height;
        
        textView.frame = frame;
        
        NSLog(@"text----%@",text);
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
            //既然是超出部分截取了，哪一定是最大限制了。
        }
        return NO;
    }
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    [self refreshTextViewSize:textView];
}

- (void)dealloc {
    [self clearNotificationAndGesture];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

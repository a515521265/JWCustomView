//
//  JWTextView.h
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/7.
//
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TextViewImportStyle) {
    TextViewImportStyleNormal = 0,     //无限制
    TextViewImportStyleNumber = 1,     //限制数字输入格式 (首位不可以为0)
    TextViewImportStylePassword = 2,   //限制密码输入格式 (暂时没有限制)
    TextViewImportStyleMoney = 3,       //限制金钱输入格式  (输入格式：最低输入1.00)
    TextViewImportStyleMinMoney = 4,       //限制金钱输入格式 (输入格式：最低输入0.01)
    TextViewImportStyleRightfulMoney = 5,       //限制合法的小数金额限制 (合法的小数输入规则)
    TextViewImportStyleNumberTwo = 6,     //限制数字输入格式 (首位可以为0)
    TextViewImportStyleProhibitImport = 7,     //禁止输入
    TextViewImportStyleChina = 8,     //中文输入
};


@interface JWTextView : UITextView

@property (nonatomic,assign)TextViewImportStyle importStyle;

@property (nonatomic,copy) void(^importBackString)(NSString * backStr);

@property (nonatomic,copy) void(^backHeight)(CGFloat);

@property (nonatomic,assign) CGFloat maxlength;

@property (nonatomic,assign) BOOL zoomText; //是否缩放文字

@end

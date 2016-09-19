//
//  DWBankModel.h
//  supplier
//
//  Created by 薄睿杰 on 16/7/5.
//  Copyright © 2016年 Nathaniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWBankModel : NSObject
@property (nonatomic,assign) NSInteger sortNum;
@property (nonatomic,strong) NSString * bankName; //银行名称
@property (nonatomic,assign) NSInteger bankId; //id
@property (nonatomic,strong) NSString * bankCode; //银行编码
@property (nonatomic,assign) NSInteger isHot; //是否热门
@property (nonatomic,assign) NSInteger bankType;
@property (nonatomic,strong) NSString * bankIcon; //图片地址
@property (nonatomic,assign) NSInteger bindcardId;
@property (nonatomic,strong) NSString * singleLimitMoney;//充值单笔限额
@property (nonatomic,strong) NSString * payInfo;//到账说明
@property (nonatomic,strong) NSString * singleLimitPay;//代付单笔限额 转账限额 提现限额

 + (NSString *)backbankenameWithBanknumber:(NSString *)banknumber;

@end

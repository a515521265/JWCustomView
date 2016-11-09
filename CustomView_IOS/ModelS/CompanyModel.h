//
//  CompanyModel.h
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/8.
//
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface CompanyModel : NSObject

@property (nonatomic,strong) NSString * companyName; //公司名称

@property (nonatomic,strong) NSMutableArray <GoodsModel *> * goodsArr; //商品数组

@end

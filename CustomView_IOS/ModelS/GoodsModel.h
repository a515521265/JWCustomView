//
//  GoodsModel.h
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/8.
//
//

#import <Foundation/Foundation.h>
@class SpecsModel;
@interface GoodsModel : NSObject

@property (nonatomic,strong) NSString * goodsName;

@property (nonatomic,strong) NSArray <SpecsModel *>* specsArr;

@end

//
//  GridTableViewCell.h
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/17.
//
//

#import <UIKit/UIKit.h>

@interface GridTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray * models;

@property (nonatomic,strong) NSArray * imageArr;

@property (nonatomic,copy) void(^tapindex) (NSString * backStr);

@end

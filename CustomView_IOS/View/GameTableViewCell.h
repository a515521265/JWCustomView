//
//  GameTableViewCell.h
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/23.
//
//

#import <UIKit/UIKit.h>

#import "CustomCellModel.h"

@interface GameTableViewCell : UITableViewCell

@property (nonatomic,strong) CustomCellModel * cellModel;

@property (nonatomic,copy) void(^tapBlack) ();

@property (nonatomic,copy) void(^tapWhite) ();

@end

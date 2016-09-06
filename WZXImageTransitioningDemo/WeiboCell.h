//
//  MyTableViewCell.h
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@protocol WeiboCellDelegate <NSObject>

- (void)weiboCellDidClick:(NSUInteger)index
                   images:(NSArray <UIImage *> *)images
            initialFrames:(NSArray <NSValue *> *)initialFrames;

@end

@interface WeiboCell : UITableViewCell

@property(nonatomic, strong)WeiboModel * model;
@property(nonatomic, weak)id <WeiboCellDelegate> delegate;
@end

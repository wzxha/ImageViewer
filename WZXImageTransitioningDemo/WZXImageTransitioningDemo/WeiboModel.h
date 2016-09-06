//
//  WeiboModel.h
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboModel : NSObject

@property(nonatomic, copy)NSString * title;

@property(nonatomic, copy)NSArray * images;

@property(nonatomic, assign, readonly)CGFloat rowHeight;

- (instancetype)initWithTitle:(NSString *)title images:(NSArray <UIImage *> *)images;

@end

//
//  WeiboModel.m
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel

- (instancetype)initWithTitle:(NSString *)title images:(NSArray<UIImage *> *)images {
    if (self = [super init]) {
        _title = title;
        _images = images;
    }
    return self;
}

- (CGFloat)rowHeight {
    CGFloat titleHeight = [_title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    CGFloat imageHeight = ((_images.count - 1)/3 + 1) * (([UIScreen mainScreen].bounds.size.width - 20)/3.0);
    return titleHeight + imageHeight + 25;
}

@end

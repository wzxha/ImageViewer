//
//  WZXImageViewController.h
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXImageViewController : UIViewController

/**
 *  初始化方法, 这里之所以不直接传imageViews是为了更灵活.
 *
 *  @param images        所有的image
 *  @param initialFrames 它们的初始位置
 *  @param currentIndex  当前选中第几个
 *
 *  @return WZXImageViewController对象
 */
- (instancetype)initWithImages:(NSArray <UIImage *> *)images
                 initialFrames:(NSArray <NSValue *> *)initialFrames
                  currentIndex:(NSUInteger)currentIndex;
@end

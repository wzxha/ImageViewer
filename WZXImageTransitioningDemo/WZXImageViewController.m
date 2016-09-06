//
//  WZXImageViewController.m
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WZXImageViewController.h"
#import "WZXTransitioning.h"
#import "WZXImageAnimation.h"
@interface WZXImageViewController ()

@end

@implementation WZXImageViewController {
    NSArray * _images;
    NSArray * _initialFrames;
    NSUInteger _currentIndex;
    UIScrollView * _scrollView;
}

- (instancetype)initWithImages:(NSArray <UIImage *> *)images initialFrames:(NSArray <NSValue *> *)initialFrames currentIndex:(NSUInteger)currentIndex {
    if (self = [super init]) {
        _images = images;
        _initialFrames = initialFrames;
        _currentIndex = currentIndex;
        self.view.backgroundColor = [UIColor blackColor];
        [self wzx_presentAnimation:[WZXImageAnimation new]];
        [self wzx_dismissAnimation:[WZXImageAnimation new]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController) {
        self.navigationController.navigationBarHidden = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.navigationController) {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)createUI {
    [self.view addSubview:[self scrollView]];
    
    [_images enumerateObjectsUsingBlock:^(UIImage * image, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.tag = [self tag] + idx;
        if (idx == _currentIndex) {
            CGRect rect;
            [_initialFrames[_currentIndex] getValue:&rect];
            rect.origin.x += _currentIndex*self.view.frame.size.width;
            imageView.frame = rect;
        } else {
            imageView.bounds = (CGRect){CGPointZero, image.size};
            imageView.center = CGPointMake(self.view.center.x + self.view.frame.size.width * idx, self.view.center.y);
        }
        [_scrollView addSubview:imageView];
    }];
}

- (void)showAnimation:(void(^)(BOOL finished))completion {
    UIImageView * currentImageView = (UIImageView *)[self.view viewWithTag:[self tag] + _currentIndex];
    [UIView animateWithDuration:0.3 animations:^{
        currentImageView.bounds = (CGRect){CGPointZero, currentImageView.image.size};
        currentImageView.center = CGPointMake(self.view.center.x + _currentIndex*self.view.frame.size.width, self.view.center.y);
    } completion:completion];
}

- (void)hideAnimation:(void(^)(BOOL finished))completion {
    NSUInteger currentIndex = _scrollView.contentOffset.x/self.view.frame.size.width;
    UIImageView * currentImageView = (UIImageView *)[self.view viewWithTag:[self tag] + currentIndex];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect;
        [_initialFrames[currentIndex] getValue:&rect];
        rect.origin.x += currentIndex*self.view.frame.size.width;
        currentImageView.frame = rect;
    } completion:completion];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * _images.count, self.view.frame.size.height);
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
        _scrollView.contentOffset = CGPointMake(_currentIndex * self.view.frame.size.width, 0);
    }
    return _scrollView;
}

- (NSInteger)tag {
    return 10000;
}

- (void)click:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

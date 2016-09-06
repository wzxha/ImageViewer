//
//  ViewController.m
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "ViewController.h"
#import "WZXTransitioning.h"
#import "WZXImageAnimation.h"
#import "WZXImageViewController.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "Masonry.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource, WeiboCellDelegate>

@end

@implementation ViewController {
    UITableView * _tableView;
    UICollectionView * _collectionView;
    NSArray * _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getData];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:[self tableView]];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)getData {
    _datas = @[[[WeiboModel alloc]initWithTitle:@"Title1" images:@[[UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   ]],
               [[WeiboModel alloc]initWithTitle:@"Title2" images:@[[UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   ]],
               [[WeiboModel alloc]initWithTitle:@"Title3" images:@[[UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"]]],
               [[WeiboModel alloc]initWithTitle:@"Title4" images:@[[UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"]]],
               [[WeiboModel alloc]initWithTitle:@"Title5" images:@[[UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"]]],
               [[WeiboModel alloc]initWithTitle:@"Title6" images:@[[UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"],
                                                                   [UIImage imageNamed:@"IMG_8371.JPG"]]]];
}

- (void)click:(UITapGestureRecognizer *)sender {
    [self presentViewController:[[WZXImageViewController alloc] initWithImages:[self getImages]     initialFrames:[self getImageFrames] currentIndex:sender.view.tag - [self tag]] animated:YES completion:^{
    }];
}

- (NSArray <UIImage *> *)getImages {
    return @[((UIImageView *)[self.view viewWithTag:[self tag]+0]).image,
             ((UIImageView *)[self.view viewWithTag:[self tag]+1]).image,
             ((UIImageView *)[self.view viewWithTag:[self tag]+2]).image];
}

- (NSArray <NSValue *> *)getImageFrames {
    return @[[NSValue valueWithCGRect:[self.view viewWithTag:[self tag]+0].frame],
             [NSValue valueWithCGRect:[self.view viewWithTag:[self tag]+1].frame],
             [NSValue valueWithCGRect:[self.view viewWithTag:[self tag]+2].frame]];
}

- (NSInteger)tag {
    return 10000;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[WeiboCell class] forCellReuseIdentifier:@"MyTableViewCell"];
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboCell * myCell = (WeiboCell *)cell;
    myCell.delegate = self;
    [myCell setModel:_datas[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((WeiboModel *)_datas[indexPath.row]).rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (void)weiboCellDidClick:(NSUInteger)index images:(NSArray<UIImage *> *)images initialFrames:(NSArray<NSValue *> *)initialFrames {
    [self presentViewController:[[WZXImageViewController alloc] initWithImages:images initialFrames:initialFrames currentIndex:index] animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

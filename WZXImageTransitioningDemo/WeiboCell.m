
//
//  MyTableViewCell.m
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WeiboCell.h"
#import "Masonry.h"
@implementation WeiboCell {
    UILabel * _titleLabel;
    UIView * _imagesView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor grayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:[self titleLabel]];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(5);
    }];
}

- (void)setModel:(WeiboModel *)model {
    _model = model;
    
    if (_imagesView) {
        [_imagesView removeFromSuperview];
        _imagesView = nil;
    }

    _titleLabel.text = model.title;
    
    CGFloat height = (([UIScreen mainScreen].bounds.size.width - 20)/3.0) * ((_model.images.count - 1)/3 + 1);
    [self.contentView addSubview:[self imagesView]];
    [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width - 20));
    }];
    
    [_model.images enumerateObjectsUsingBlock:^(UIImage * image, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
        imageView.tag = [self tag] + idx;
        [_imagesView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imagesView).offset((([UIScreen mainScreen].bounds.size.width - 20)/3.0) * (idx/3));
            make.left.equalTo(_imagesView).offset((([UIScreen mainScreen].bounds.size.width - 20)/3.0) * (idx%3));
            make.size.mas_equalTo(CGSizeMake((([UIScreen mainScreen].bounds.size.width - 20)/3.0), (([UIScreen mainScreen].bounds.size.width - 20)/3.0)));
        }];
    }];
    
    [self layoutIfNeeded];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)imagesView {
    if (!_imagesView) {
        _imagesView = [UIView new];
    }
    return _imagesView;
}

- (void)click:(UITapGestureRecognizer *)sender {
    NSMutableArray * initialFrames = [NSMutableArray array];
    for (int i = 0; i < _model.images.count; i++) {
        UIImageView * imageView = (UIImageView *)[self.contentView viewWithTag:[self tag] + i];
        CGRect realRect = [self.contentView convertRect:[_imagesView convertRect:imageView.frame toView:self] toView:self.superview.superview.superview];
        [initialFrames addObject:[NSValue valueWithCGRect:realRect]];
    }
    if (self.delegate) {
        [self.delegate weiboCellDidClick:sender.view.tag - [self tag] images:_model.images initialFrames:initialFrames];
    }
}

- (NSInteger)tag {
    return 10000;
}

@end

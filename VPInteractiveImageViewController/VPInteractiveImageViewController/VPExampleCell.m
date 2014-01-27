//
//  VPExampleCell.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPExampleCell.h"
#import "VPInteractiveImageView.h"

@interface VPExampleCell ()
@property (nonatomic) VPInteractiveImageView *imageView;
@end

@implementation VPExampleCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[VPInteractiveImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

#pragma mark - Getter / Setter

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

@end

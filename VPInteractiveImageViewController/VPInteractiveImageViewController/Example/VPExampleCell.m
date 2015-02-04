//
//  VPExampleCell.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPExampleCell.h"

@interface VPExampleCell ()

@end

@implementation VPExampleCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[VPInteractiveImageView alloc] initWithFrame:CGRectZero];
        _imageView.pinchGestureEnabled = YES;
        _imageView.panCloseGestureEnabled = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

@end

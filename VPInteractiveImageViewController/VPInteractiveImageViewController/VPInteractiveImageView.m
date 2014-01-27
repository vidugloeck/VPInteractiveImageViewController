//
//  VPInteractiveImageView.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPInteractiveImageView.h"

@implementation VPInteractiveImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(imageViewTapped:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)imageViewTapped:(UITapGestureRecognizer *)recognizer {
    //TODO: Present InteractiveViewController
}

@end

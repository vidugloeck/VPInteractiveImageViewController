//
//  VPInteractiveImageView.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPInteractiveImageView.h"
#import "VPInteractiveImageViewController.h"

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
    VPInteractiveImageViewController *controller = [[VPInteractiveImageViewController alloc] init];
    controller.image = self.image;
    if (self.presentingViewController) {
        [self.presentingViewController presentViewController:controller animated:YES completion:NULL];
    } else {
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:controller
                                                                                         animated:YES
                                                                                       completion:NULL];
    }
}

@end

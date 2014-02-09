//
//  VPTransitionDelegate.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 01/02/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPTransitionDelegate.h"
#import "VPTransitionAnimator.h"
#import "VPInteractiveImageView.h"

@interface VPTransitionDelegate ()
@property (nonatomic, weak) VPInteractiveImageView *interactiveImageView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation VPTransitionDelegate

- (id)initWithInteractiveImageView:(VPInteractiveImageView *)interactiveImageView
               fullScreenImageView:(UIImageView *)imageView;{
    self = [super init];
    if (self) {
        _interactiveImageView = interactiveImageView;
        _imageView = imageView;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [[VPTransitionAnimator alloc] initWithInteractiveImageView:self.interactiveImageView
                                              fullScreenImageViewView:self.imageView];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[VPTransitionAnimator alloc] initWithInteractiveImageView:self.interactiveImageView
                                              fullScreenImageViewView:self.imageView];
}
@end

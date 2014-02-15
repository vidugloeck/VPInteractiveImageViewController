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
@property (nonatomic) VPTransitionAnimator *transitionAnimator;
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

- (VPTransitionAnimator *)transitionAnimator {
    if (!_transitionAnimator) {
        _transitionAnimator = [[VPTransitionAnimator alloc] initWithInteractiveImageView:self.interactiveImageView
                                                                 fullScreenImageViewView:self.imageView];
    }
    return _transitionAnimator;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self.transitionAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    VPTransitionAnimator *transitionAnimator =  self.transitionAnimator;
    self.transitionAnimator = nil;
    return transitionAnimator;
}
@end

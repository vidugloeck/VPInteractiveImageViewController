//
//  VPTransitionAnimator.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 01/02/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPTransitionAnimator.h"
#import "VPInteractiveImageView.h"

@interface VPTransitionAnimator ()
@property (nonatomic) VPInteractiveImageView *interactiveImageView;
@property (nonatomic) UIImageView *imageView;
@end

@implementation VPTransitionAnimator

- (id)initWithInteractiveImageView:(VPInteractiveImageView *)interactiveImageView
           fullScreenImageViewView:(UIImageView *)imageView {
    self = [super init];
    if (self) {
        _interactiveImageView = interactiveImageView;
        _imageView = imageView;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.33;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if (fromViewController.presentedViewController == toViewController) {
        [self presentWithTransitionContext:transitionContext];
    } else {
        [self dismissWithTransitionContext:transitionContext];
    }
}

#pragma mark - Private methods

- (void)presentWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGRect endFrame = [transitionContext initialFrameForViewController:fromViewController];

    CGRect bla = self.imageView.frame;
    self.imageView.frame = [containerView convertRect:self.interactiveImageView.frame
                                                    fromView:self.interactiveImageView.superview];
    toViewController.view.frame = endFrame;

    [containerView addSubview:toViewController.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         self.imageView.frame = bla;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)dismissWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGRect endFrame = [transitionContext initialFrameForViewController:fromViewController];

    [containerView addSubview:toViewController.view];
    [containerView addSubview:fromViewController.view];

    fromViewController.view.frame = endFrame;
    toViewController.view.frame = endFrame;

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.frame = CGRectZero;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}
@end

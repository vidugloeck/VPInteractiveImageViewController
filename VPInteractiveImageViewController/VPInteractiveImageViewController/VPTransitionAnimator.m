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
@property (nonatomic) CGRect originFrame;
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

    UIColor *backgroundColor = toViewController.view.backgroundColor;

    self.originFrame = [containerView convertRect:self.interactiveImageView.frame
                                         fromView:self.interactiveImageView.superview];
    CGRect finalImageViewRect = self.imageView.frame;
    self.imageView.frame = self.originFrame;
    self.imageView.transform = [self affineTransformForInterfaceOrientation:toViewController.interfaceOrientation];
    toViewController.view.frame = endFrame;
    toViewController.view.backgroundColor = [UIColor clearColor];

    [containerView addSubview:toViewController.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         self.imageView.frame = finalImageViewRect;
                         self.imageView.transform = CGAffineTransformIdentity;
                         toViewController.view.layer.backgroundColor = [backgroundColor CGColor];
                     } completion:^(BOOL finished) {
        toViewController.view.backgroundColor = backgroundColor;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
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
//                         fromViewController.view.frame = self.originFrame;
                         self.imageView.transform = [self affineTransformForInterfaceOrientation:fromViewController.interfaceOrientation];
                         self.imageView.frame = [fromViewController.view convertRect:self.originFrame fromView:containerView];
                         fromViewController.view.layer.backgroundColor = 0;
                     } completion:^(BOOL finished) {
                         fromViewController.view.layer.backgroundColor = [[UIColor clearColor] CGColor];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


- (CGAffineTransform)affineTransformForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle;
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = -M_PI_2;
            break;
        default:
            angle = 0;
            break;
    }
    return CGAffineTransformMakeRotation(angle);
}
@end

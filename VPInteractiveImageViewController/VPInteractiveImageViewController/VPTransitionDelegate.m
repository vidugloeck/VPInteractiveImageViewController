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
#import "VPTransitionInteractor.h"
#import "VPInteractiveImageViewController.h"

@interface VPTransitionDelegate ()
@property (nonatomic, weak) VPInteractiveImageView *interactiveImageView;
@property (nonatomic) VPTransitionAnimator *transitionAnimator;
@property (nonatomic) VPTransitionInteractor *presentingTransitionInteractor;
@property (nonatomic) VPTransitionInteractor *dismissingTransitionInteractor;
@end

@implementation VPTransitionDelegate

- (id)initWithInteractiveImageView:(VPInteractiveImageView *)interactiveImageView
               fullScreenImageView:(UIImageView *)imageView {
    self = [super init];
    if (self) {
        _interactiveImageView = interactiveImageView;
        _imageView = imageView;
        _presentingTransitionInteractor = [[VPTransitionInteractor alloc] initWithViewController:nil
                                                                                   pinchableView:_interactiveImageView];
    }
    return self;
}

#pragma mark - Getter / Setter

- (void)setPinchGestureEnabled:(BOOL)pinchGestureEnabled {
    _pinchGestureEnabled = pinchGestureEnabled;
    self.presentingTransitionInteractor.pinchGestureEnabled = _pinchGestureEnabled;
    self.dismissingTransitionInteractor.pinchGestureEnabled = _pinchGestureEnabled;
}

- (void)setPanCloseGestureEnabled:(BOOL)panCloseGestureEnabled {
    _panCloseGestureEnabled = panCloseGestureEnabled;
    self.dismissingTransitionInteractor.panCloseGestureEnabled = _panCloseGestureEnabled;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.transitionAnimator = nil;
    self.dismissingTransitionInteractor = [[VPTransitionInteractor alloc] initWithViewController:presented
                                                                                   pinchableView:self.imageView];
    self.dismissingTransitionInteractor.pinchGestureEnabled = self.pinchGestureEnabled;
    self.dismissingTransitionInteractor.panCloseGestureEnabled = self.panCloseGestureEnabled;
    return self.transitionAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    VPTransitionAnimator *transitionAnimator =  self.transitionAnimator;
    return transitionAnimator;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (!self.presentingTransitionInteractor.isInteractiveTransition)
        return nil;
    return self.presentingTransitionInteractor;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (!self.dismissingTransitionInteractor.isInteractiveTransition)
        return nil;
    return self.dismissingTransitionInteractor;
}

#pragma mark - Helper methods

- (VPTransitionAnimator *)transitionAnimator {
    if (!_transitionAnimator) {
        _transitionAnimator = [[VPTransitionAnimator alloc] initWithInteractiveImageView:self.interactiveImageView
                                                                 fullScreenImageViewView:self.imageView];
    }
    return _transitionAnimator;
}

@end

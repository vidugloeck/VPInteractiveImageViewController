//
//  VPTransitionInteractor.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 16/02/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPTransitionInteractor.h"
#import "VPInteractiveImageView.h"

@interface VPTransitionInteractor () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UIView *pinchableView;
@property (nonatomic) CGFloat fixedScale;
@property (nonatomic) CGPoint translation;
@property (nonatomic) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation VPTransitionInteractor

- (id)initWithViewController:(UIViewController *)viewController pinchableView:(UIView *)pinchableView {
    self = [super init];
    if (self) {
        _viewController = viewController;
        _pinchableView = pinchableView;
        _pinchableView.userInteractionEnabled = YES;
        [self setupGestureRecognizer];
    }
    return self;
}

- (void)setupGestureRecognizer {
    if (self.viewController) {
        self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(handlePinchClose:)];
        self.pinchGestureRecognizer.delegate = self;
    } else {
        self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(handlePinchOpen:)];
    }
    self.pinchableView.userInteractionEnabled = YES;
    [self.pinchableView addGestureRecognizer:self.pinchGestureRecognizer];

    if (!self.viewController)
        return;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanClose:)];
    [self.pinchableView addGestureRecognizer:self.panGestureRecognizer];
}

#pragma mark - Getter / Setter

- (void)setPinchGestureEnabled:(BOOL)pinchGestureEnabled {
    _pinchGestureEnabled = pinchGestureEnabled;
    self.pinchGestureRecognizer.enabled = _pinchGestureEnabled;
}

- (void)setPanCloseGestureEnabled:(BOOL)panCloseGestureEnabled {
    _panCloseGestureEnabled = panCloseGestureEnabled;
    self.panGestureRecognizer.enabled = _panCloseGestureEnabled;
}
#pragma mark - Gesture actions

- (void)handlePinchOpen:(UIPinchGestureRecognizer *)pinch {
    CGFloat scale = pinch.scale;
    switch (pinch.state) {
        case UIGestureRecognizerStateBegan: {
            self.fixedScale = 5;
            self.isInteractiveTransition = YES;
            [(VPInteractiveImageView *)self.pinchableView presentFullscreen];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = (1.0f / _fixedScale) * scale;
            [self updateInteractiveTransition:(percent < 0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = (1.0f / _fixedScale) * scale;
            BOOL cancelled = ([pinch velocity] < 5.0 && percent <= 0.3);

            if (cancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            self.isInteractiveTransition = NO;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self cancelInteractiveTransition];
            self.isInteractiveTransition = NO;
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

-(void)handlePinchClose:(UIPinchGestureRecognizer *)pinch {
    CGFloat scale = pinch.scale;
    switch (pinch.state) {
        case UIGestureRecognizerStateBegan: {
            //TODO: Need to introduce a proper interface to get the scrollView
            UIScrollView *scrollView = (UIScrollView *)self.pinchableView.superview;
            if (scale >= 1 || scrollView.zoomScale > scrollView.minimumZoomScale) {
                pinch.enabled = NO;
                pinch.enabled = YES;
                return;
            } else {
                scrollView.pinchGestureRecognizer.enabled = NO;
                scrollView.pinchGestureRecognizer.enabled = YES;
            }
            self.fixedScale = scale;
            self.isInteractiveTransition = YES;
            [self.viewController dismissViewControllerAnimated:YES
                                                    completion:NULL];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = (1.0 - scale/_fixedScale);
            [self updateInteractiveTransition:(percent < 0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = (1.0 - scale/_fixedScale);
            BOOL cancelled = ([pinch velocity] < 5.0 && percent <= 0.3);

            if (cancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            self.isInteractiveTransition = NO;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self cancelInteractiveTransition];
            self.isInteractiveTransition = NO;
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

- (void)handlePanClose:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint currentTranlation = [gestureRecognizer translationInView:self.pinchableView];;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            //TODO: Need to introduce a proper interface to get the scrollView
            UIScrollView *scrollView = (UIScrollView *)self.pinchableView.superview;
            if (scrollView.zoomScale > scrollView.minimumZoomScale) {
                gestureRecognizer.enabled = NO;
                gestureRecognizer.enabled = YES;
                return;
            }
            self.translation = CGPointZero;
            self.isInteractiveTransition = YES;
            [self.viewController dismissViewControllerAnimated:YES
                                                    completion:NULL];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            self.translation = CGPointMake(self.translation.x + currentTranlation.x, self.translation.y + currentTranlation.y);
            CGFloat percent = [self percent];
            [self updateInteractiveTransition:percent];
            self.pinchableView.transform = CGAffineTransformTranslate(self.pinchableView.transform, currentTranlation.x, currentTranlation.y);
            [gestureRecognizer setTranslation:CGPointZero inView:self.pinchableView];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat percent;
            percent = [self percent];
            BOOL cancelled = ([gestureRecognizer velocityInView:self.pinchableView].y < 5.0 && percent <= 0.3);
            if (cancelled) {
                [self cancelInteractiveTransition];
            } else {
                
                [self finishInteractiveTransition];
            }
            self.isInteractiveTransition = NO;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self cancelInteractiveTransition];
            self.isInteractiveTransition = NO;
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Helper methods

- (CGFloat)percent {
    CGFloat percent = ((1.0f/200) * self.translation.y);
    percent = (percent > 100) ? 100 : percent;
    percent = (percent < 0) ? 0 : percent;
    return percent;
}

@end

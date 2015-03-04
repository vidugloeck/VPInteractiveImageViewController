//
//  VPInteractiveImageView.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPInteractiveImageView.h"
#import "VPInteractiveImageViewController.h"
#import "VPTransitionDelegate.h"

@interface VPInteractiveImageView ()
@property (nonatomic) VPTransitionDelegate *transitionDelegate;
@end

@implementation VPInteractiveImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(imageViewTapped:)];
        [self addGestureRecognizer:recognizer];
        _pinchGestureEnabled = YES;
        _panCloseGestureEnabled = YES;
        _transitionDelegate = [[VPTransitionDelegate alloc] initWithInteractiveImageView:self fullScreenImageView:nil];
        _transitionDelegate.pinchGestureEnabled = _pinchGestureEnabled;
        _transitionDelegate.panCloseGestureEnabled = _panCloseGestureEnabled;
    }
    return self;
}

#pragma mark - Getter / Setter

- (void)setPinchGestureEnabled:(BOOL)pinchGestureEnabled {
    _pinchGestureEnabled = pinchGestureEnabled;
    self.transitionDelegate.pinchGestureEnabled = pinchGestureEnabled;
}

- (void)setPanCloseGestureEnabled:(BOOL)panCloseGestureEnabled {
    _panCloseGestureEnabled = panCloseGestureEnabled;
    self.transitionDelegate.panCloseGestureEnabled = panCloseGestureEnabled;
}

- (void)imageViewTapped:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(interactiveImageViewWillPresent:)]) {
        [self.delegate performSelector:@selector(interactiveImageViewWillPresent:)
                            withObject:self];
    }
    [self presentFullscreen];
}

- (void)presentFullscreen {
    VPInteractiveImageViewController *controller = [[VPInteractiveImageViewController alloc] initWithInteractiveImageView:self];
    controller.imageView.image = self.image;
    self.transitionDelegate.imageView = controller.imageView;
    controller.transitioningDelegate = self.transitionDelegate;
    if (self.presentingViewController) {
        [self.presentingViewController presentViewController:controller
                                                    animated:YES
                                                  completion:NULL];
    } else {
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:controller
                                                                                         animated:YES
                                                                                       completion:NULL];
    }
}

@end

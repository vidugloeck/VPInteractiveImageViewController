//
//  VPTransitionInteractor.h
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 16/02/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VPInteractiveImageView;
@interface VPTransitionInteractor : UIPercentDrivenInteractiveTransition

@property (nonatomic) BOOL isInteractiveTransition;
@property (nonatomic) BOOL isPresenting;
@property (nonatomic, weak) id delegate;
@property (nonatomic) BOOL pinchGestureEnabled;
@property (nonatomic) BOOL panCloseGestureEnabled;

- (id)initWithViewController:(UIViewController *)viewController pinchableView:(UIView *)pinchableView;
@end

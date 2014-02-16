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

@property(nonatomic, strong) id delegate;

- (id)initWithViewController:(UIViewController *)viewController pinchableView:(UIView *)pinchableView;
@end

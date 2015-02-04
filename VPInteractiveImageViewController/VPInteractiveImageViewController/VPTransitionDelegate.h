//
//  VPTransitionDelegate.h
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 01/02/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VPInteractiveImageView;
@interface VPTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic) BOOL pinchGestureEnabled;
@property (nonatomic) BOOL panCloseGestureEnabled;
- (id)initWithInteractiveImageView:(VPInteractiveImageView *)interactiveImageView fullScreenImageView:(UIImageView *)imageView;
@end

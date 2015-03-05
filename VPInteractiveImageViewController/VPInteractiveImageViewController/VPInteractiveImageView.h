//
//  VPInteractiveImageView.h
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPInteractiveImageViewDelegate;

@interface VPInteractiveImageView : UIImageView

@property (nonatomic, weak) id<VPInteractiveImageViewDelegate> delegate;
@property (nonatomic) UIViewController *presentingViewController;
@property (nonatomic) BOOL pinchGestureEnabled;
@property (nonatomic) BOOL panCloseGestureEnabled;

- (void)presentFullscreen;
@end

@protocol VPInteractiveImageViewDelegate <NSObject>

@optional
- (void)interactiveImageViewWillPresent:(VPInteractiveImageView *)imageView;
- (void)interactiveImageViewWillDismiss:(VPInteractiveImageView *)imageView;

@end

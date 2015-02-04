//
//  VPInteractiveImageView.h
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPInteractiveImageView : UIImageView

@property (nonatomic) UIViewController *presentingViewController;
@property (nonatomic) BOOL pinchGestureEnabled;
@property (nonatomic) BOOL panCloseGestureEnabled;

- (void)presentFullscreen;
@end

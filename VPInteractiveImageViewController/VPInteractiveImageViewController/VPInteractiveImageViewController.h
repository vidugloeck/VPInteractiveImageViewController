//
//  VPInteractiveImageViewController.h
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VPInteractiveImageView;

@interface VPInteractiveImageViewController : UIViewController
@property (nonatomic, readonly) UIImageView *imageView;

- (instancetype)initWithInteractiveImageView:(VPInteractiveImageView *)interactiveImageView NS_DESIGNATED_INITIALIZER;

@end

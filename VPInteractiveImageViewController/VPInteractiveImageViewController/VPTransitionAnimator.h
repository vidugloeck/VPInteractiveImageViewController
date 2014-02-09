//
//  VPTransitionAnimator.h
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 01/02/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VPInteractiveImageView;
@interface VPTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
- (id)initWithInteractiveImageView:(VPInteractiveImageView *)interActiveImageView
          fullScreenImageViewView:(UIImageView *)imageView;
@end

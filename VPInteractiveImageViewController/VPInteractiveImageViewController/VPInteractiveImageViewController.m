//
//  VPInteractiveImageViewController.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPInteractiveImageViewController.h"

@interface VPInteractiveImageViewController ()
@property (nonatomic) UIImageView *imageView;
@end

@implementation VPInteractiveImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
	self.imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}

#pragma mark - Getter / Setter

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

@end

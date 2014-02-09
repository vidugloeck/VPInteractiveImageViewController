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

- (id)init {
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [self.view addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
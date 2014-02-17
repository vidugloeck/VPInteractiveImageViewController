//
//  VPInteractiveImageViewController.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPInteractiveImageViewController.h"

@interface VPInteractiveImageViewController () <UIScrollViewDelegate>
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;
@end

@implementation VPInteractiveImageViewController

- (id)init {
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDoubleTapped:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        [self.view addGestureRecognizer:doubleTapRecognizer];
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [_tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self.view addGestureRecognizer:_tapRecognizer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupScrollView];

    self.view.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:self.imageView];

}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.autoresizingMask = self.view.autoresizingMask;
    [self.view addSubview:self.scrollView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDoubleTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.scrollView.zoomScale < self.scrollView.maximumZoomScale) {
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.tapRecognizer.enabled = NO;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (scale <= self.scrollView.minimumZoomScale) {
        self.tapRecognizer.enabled = YES;
    }
}

@end

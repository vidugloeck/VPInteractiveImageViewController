//
//  VPInteractiveImageViewController.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPInteractiveImageViewController.h"
#import "VPInteractiveImageView.h"

@interface VPInteractiveImageViewController () <UIScrollViewDelegate>
@property (nonatomic, weak, readonly) VPInteractiveImageView *interactiveImageView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic) CGFloat maximumZoomScale;
@end

@implementation VPInteractiveImageViewController

- (instancetype)initWithInteractiveImageView:(VPInteractiveImageView *)interactiveImageView {
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.maximumZoomScale = 3.0;
        _interactiveImageView = interactiveImageView;
    }
    return self;
}

- (void)dealloc {
    self.scrollView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapRecognizer];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [_tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    [self.view addGestureRecognizer:_tapRecognizer];
    
    [self setupScrollView];
    self.view.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:self.imageView];
    
    [self adjustImageViewFrame];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = self.maximumZoomScale;
    [self.view addSubview:self.scrollView];
}

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if ([self.interactiveImageView.delegate respondsToSelector:@selector(interactiveImageViewWillDismiss:)]) {
        [self.interactiveImageView.delegate performSelector:@selector(interactiveImageViewWillDismiss:)
                                                 withObject:self.interactiveImageView];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDoubleTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.scrollView.zoomScale < self.scrollView.maximumZoomScale) {
        [self zoomInWithPoint:[gestureRecognizer locationInView:self.imageView]];
    } else {
        [self zoomOut];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.minimumZoomScale = [self minimumZoomScale];
    if (self.scrollView.zoomScale <= [self minimumZoomScale]) {
        [self zoomOut]; // reset zoomScale and contentsize to original state
    }
}

- (void)zoomInWithPoint:(CGPoint)point {
    CGFloat newScale = self.maximumZoomScale;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:point];
    [self.scrollView zoomToRect:zoomRect animated:YES];
}

- (void)zoomOut {
    self.scrollView.minimumZoomScale = [self minimumZoomScale];
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    self.scrollView.contentSize = self.scrollView.bounds.size;
    [self adjustImageViewFrame];
}

- (void)adjustImageViewFrame {
    self.imageView.frame = CGRectMake(0, 0,
                                      self.scrollView.bounds.size.width,
                                      self.scrollView.bounds.size.height);
}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center {
    CGRect zoomRect = CGRectZero;
    zoomRect.size.height = floor(self.view.bounds.size.height / scale);
    zoomRect.size.width  = floor(self.view.bounds.size.width / scale);
    zoomRect.origin.x    = center.x - floor(zoomRect.size.width / 2.0);
    zoomRect.origin.y    = center.y - floor(zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (CGFloat)minimumZoomScale {
    CGFloat scale = self.scrollView.bounds.size.width / self.imageView.bounds.size.width;
    return scale;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.tapRecognizer.enabled = NO;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (scale <= [self minimumZoomScale]) {
        self.tapRecognizer.enabled = YES;
    }
}

@end

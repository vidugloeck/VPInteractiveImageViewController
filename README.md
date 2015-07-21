VPInteractiveImageViewController
================================

An ImageViewController which presents Images Fullscreen and can be interactively dismissed as seen in the Facebook app

Getting started
---------------

### Install using CocoaPods

	pod 'VPInteractiveImageView', '~> 0.2.0'

### Usage

Add the import to your View Controller

	#import <VPInteractiveImageView.h>

Present your interactive image in fullscreen

	- (void)presentInteractiveImage {
		VPInteractiveImageView *interactiveImageView = [[VPInteractiveImageView alloc] initWithImage:myImageView.image];
	    [interactiveImageView presentFullscreen];
	}
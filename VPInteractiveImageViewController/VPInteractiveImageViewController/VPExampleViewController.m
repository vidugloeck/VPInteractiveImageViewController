//
//  VPExampleViewController.m
//  VPInteractiveImageViewController
//
//  Created by Vidu Pirathaparajah on 27/01/14.
//  Copyright (c) 2014 Vidu Pirathaparajah. All rights reserved.
//

#import "VPExampleViewController.h"
#import "VPExampleCell.h"

#define CellID @"CellID"

@interface VPExampleViewController ()

@end

@implementation VPExampleViewController

- (id)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150.0f, 100.0f);
    layout.sectionInset = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f);
    self = [super initWithCollectionViewLayout:layout];;
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[VPExampleCell class] forCellWithReuseIdentifier:CellID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VPExampleCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellID
                                                                                forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

@end

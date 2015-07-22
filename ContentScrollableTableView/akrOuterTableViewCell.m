//
//  akrOuterTableViewCell.m
//  ContentScrollableTableView
//
//  Created by utusemi on 15/7/19.
//  Copyright © 2015年 utusemi. All rights reserved.
//

#import "akrOuterTableViewCell.h"
#import "akrInnerCollectionViewCell.h"


#define kInnerCellID @"innerCell"

@interface akrOuterTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end

@implementation akrOuterTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    UINib *innerCellNib = [UINib nibWithNibName:@"akrInnerCollectionViewCell" bundle:nil];
    [self.contentCollectionView registerNib:innerCellNib forCellWithReuseIdentifier:kInnerCellID];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    akrInnerCollectionViewCell *innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:kInnerCellID forIndexPath:indexPath];
    
    [innerCell.contentLabel setText:[NSString stringWithFormat:@"%u", arc4random() % 1000]];
    
    return innerCell;
}

- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    [self setSelected:YES];
    [UIView animateWithDuration:1 animations:^{
        NSLog(@"do segue by tap.");
    } completion:^(BOOL finished) {
        [self setSelected:NO];
        
    }];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self setHighlighted:YES];
            break;
        case UIGestureRecognizerStateChanged:
            if (!CGRectContainsPoint(self.bounds, [gesture locationInView:self.innerScrollView])) {
                [self setHighlighted:NO];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.isHighlighted) {
                NSLog(@"do segue by long press.");
                [self setHighlighted:NO];
            }
            break;
        default:
            break;
    }
}

@end

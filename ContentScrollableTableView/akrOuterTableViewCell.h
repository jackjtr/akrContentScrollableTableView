//
//  akrOuterTableViewCell.h
//  ContentScrollableTableView
//
//  Created by utusemi on 15/7/19.
//  Copyright © 2015年 utusemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface akrOuterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;

@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIScrollView *innerScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *contentCollectionViewFlowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentCollectionViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentCollectionViewHeight;

@end

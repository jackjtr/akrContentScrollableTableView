//
//  akrOuterTableHeader.h
//  ContentScrollableTableView
//
//  Created by utusemi on 15/7/20.
//  Copyright © 2015年 utusemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface akrOuterTableHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *nameHeader;

@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIScrollView *headersScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameHeaderWidth;
@property (weak, nonatomic) IBOutlet UIView *innerHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *innerHeaderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *innerHeaderWidth;

@end

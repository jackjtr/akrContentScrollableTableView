//
//  ViewController.m
//  ContentScrollableTableView
//
//  Created by utusemi on 15/7/19.
//  Copyright © 2015年 utusemi. All rights reserved.
//

#import "akrMainViewController.h"
#import "akrOuterTableViewCell.h"
#import "akrInnerScrollView.h"
#import "akrOuterTableHeader.h"
#import "UIImage+akrUIColor.h"

#define kOuterCellID @"outerCell"
#define kOuterHeaderID @"outerHeader"
#define kRowNumber 40
#define kColumnNumber 12

@interface akrMainViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *outerTableView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *rightPanGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic) IBOutletCollection(UIScrollView) NSMutableArray *innerScrollViews;
@property (nonatomic) IBOutletCollection(UIButton) NSMutableArray *outerHeaderColumns;

@end

@implementation akrMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINib *outerHeaderNib = [UINib nibWithNibName:@"akrOuterTableHeader" bundle:nil];
    [self.outerTableView registerNib:outerHeaderNib forHeaderFooterViewReuseIdentifier:kOuterHeaderID];
    UINib *outerCellNib = [UINib nibWithNibName:@"akrOuterTableViewCell" bundle:nil];
    [self.outerTableView registerNib:outerCellNib forCellReuseIdentifier:kOuterCellID];

    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.outerTableView addGestureRecognizer:self.tapGestureRecognizer];
    
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.outerTableView addGestureRecognizer:self.longPressGestureRecognizer];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kRowNumber;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    akrOuterTableViewCell *outerCell = [self.outerTableView dequeueReusableCellWithIdentifier:kOuterCellID forIndexPath:indexPath];
    
    [outerCell.nameBtn setTitle:[NSString stringWithFormat:@"g-%02ld", (long)indexPath.row] forState:UIControlStateNormal];
    [outerCell.nameBtn setTag:indexPath.row];
    [outerCell.nameBtn addTarget:self action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    outerCell.innerScrollView.delegate = self;
    [self.innerScrollViews addObject:outerCell.innerScrollView];
    [outerCell.contentCollectionViewWidth setConstant:kColumnNumber * 80.f];
    [outerCell.innerScrollView setContentSize:CGSizeMake(kColumnNumber * 80.f, 0)];
    [outerCell.contentCollectionViewHeight setConstant:66.f];
    [outerCell.contentCollectionViewFlowLayout setItemSize:CGSizeMake(80.f, 66.f)];
    
    return outerCell;
}

- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    akrOuterTableHeader *headerView = [self.outerTableView dequeueReusableHeaderFooterViewWithIdentifier:kOuterHeaderID];
    
    [headerView.nameHeader setTitle:@"Name" forState:UIControlStateNormal];
    headerView.nameHeaderWidth.constant = 99.f;
    headerView.innerHeaderWidth.constant = kColumnNumber * 80.f;
    headerView.innerHeaderHeight.constant = 44.f;
    
    for (int i=0; i<kColumnNumber; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(80.f * i, 0, 80.f, 44.f)];
        [btn setTitle:[NSString stringWithFormat:@"Col.%02d", i] forState:UIControlStateNormal];
        [btn setTitleColor:headerView.nameHeader.titleLabel.textColor forState:UIControlStateNormal];
        [btn setBackgroundColor:headerView.nameHeader.backgroundColor];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]] forState:UIControlStateHighlighted];
        [btn setTag:i];
        [btn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.innerHeaderView addSubview:btn];
        [self.outerHeaderColumns addObject:btn];
    }
    [self.innerScrollViews addObject:headerView.headersScrollView];
    headerView.headersScrollView.delegate = self;
    
    return headerView;
}

- (void)nameBtnClick:(UIButton *)sender {
    [self.outerTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    NSLog(@"do segue by tapping name:%ld", (long)sender.tag);
}

- (void)headerBtnClick:(UIButton *)sender {
    NSLog(@"do column sort:%ld", (long)sender.tag);
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self.outerTableView];
    NSIndexPath *indexPath = [self.outerTableView indexPathForRowAtPoint:touchPoint];
    [self.outerTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    NSLog(@"do segue @row:%ld", (long)indexPath.row);
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self.outerTableView];
    NSIndexPath *indexPath = [self.outerTableView indexPathForRowAtPoint:touchPoint];
    NSIndexPath *selectedIndexPath = [self.outerTableView indexPathForSelectedRow];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.outerTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        UITableViewCell *selectedCell = [self.outerTableView cellForRowAtIndexPath:selectedIndexPath];
        if (!CGRectContainsPoint(selectedCell.frame, touchPoint)) {
            [self.outerTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        }
    } else if (gesture.state == UIGestureRecognizerStateEnded && selectedIndexPath != nil) {
        NSLog(@"do segue by tapping row:%ld", (long)indexPath.row);
    }
}

- (CGFloat)tableView:(nonnull UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 66.f;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 66.f;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[akrInnerScrollView class]]) {
        scrollView.scrollEnabled = YES;
        scrollView.delegate = self;
    }
}

- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[akrInnerScrollView class]]) {
        CGFloat offsetX = scrollView.contentOffset.x;
        for (UIScrollView *item in self.innerScrollViews) {
            [item setContentOffset:CGPointMake(offsetX, 0)];
        }
    }
}

- (void)scrollViewDidEndDragging:(nonnull UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView {
    for (UIScrollView *item in self.innerScrollViews) {
        item.scrollEnabled = YES;
        item.delegate = self;
    }
}

- (BOOL)gestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint pos = [pan velocityInView:pan.view];
        if (fabs(pos.y) > fabs(pos.x)) {
            for (akrInnerScrollView *item in self.innerScrollViews) {
                item.scrollEnabled = NO;
            }
        } else {
            for (akrInnerScrollView *item in self.innerScrollViews) {
                item.scrollEnabled = YES;
            }
        }
        return YES;
    }
    return NO;
}

- (NSMutableArray *)innerScrollViews {
    if (!_innerScrollViews) {
        self.innerScrollViews = [NSMutableArray array];
    }
    return _innerScrollViews;
}

- (NSMutableArray *)outerHeaderColumns {
    if (!_outerHeaderColumns) {
        self.outerHeaderColumns = [NSMutableArray array];
    }
    return _outerHeaderColumns;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

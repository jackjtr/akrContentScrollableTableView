//
//  akrOuterTableHeader.m
//  ContentScrollableTableView
//
//  Created by utusemi on 15/7/20.
//  Copyright © 2015年 utusemi. All rights reserved.
//

#import "akrOuterTableHeader.h"

@implementation akrOuterTableHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
}


- (void)handleTap:(UITapGestureRecognizer *)gesture {
    [UIView animateWithDuration:1 animations:^{
        NSLog(@"do segue by tap.");
    } completion:^(BOOL finished) {
        
    }];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:

            break;
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
        default:
            break;
    }
}

@end

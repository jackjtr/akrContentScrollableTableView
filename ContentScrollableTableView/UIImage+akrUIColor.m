//
//  UIImage+akrUIColor.m
//  ContentScrollableTableView
//
//  Created by utusemi on 15/7/21.
//  Copyright © 2015年 utusemi. All rights reserved.
//

#import "UIImage+akrUIColor.h"

@implementation UIImage (akrUIColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

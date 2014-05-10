//
//  UIColor.m
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "UIColor.h"

@implementation UIColor (ColorUtils)

+ (UIColor *)colorWithHexString:(NSString *)colorString
{
    return [self colorWithHexString:colorString andAlpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)colorString andAlpha:(float)alpha
{
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3)
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    
    if (colorString.length == 6)
    {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:alpha];
    }
    return nil;
}

+ (UIColor *)textColorMain
{
    return [self colorWithHexString:@"333"];
}

+ (UIColor *)textColorBeta
{
    return [self colorWithHexString:@"AAA"];
}

+ (UIColor *)backgroundColor
{
    return [self colorWithHexString:@"FAFAFA"];
}

@end

//
//  Utils.m
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getConvertedQuoteSymbols:(NSString *)symbol
{
    if (symbol != (id)[NSNull null]) {
        NSDictionary *dict = @{
                               @"EUR" : @"€",
                               @"USD" : @"$",
                               @"null": @"-",
                               };
        if ([dict objectForKey:symbol])
            return [dict objectForKey:symbol];
        else
            return symbol;
    } else {
        return @"";
    }
    
}

@end

//
//  WSBase.h
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSProperty.h"

@interface WSBase : NSObject

@property (nonatomic, strong) NSString* urlString;
- (NSString *)getUrlString;
- (id)initWithParams:(WSProperty *)webServiceParameters;
- (id)initWithParams:(WSProperty *)webServiceParameters andBaseUrlString:(NSString *)baseUrlString;

- (void)performRequestwithSuccess:(void (^)(NSDictionary *))success andFailure:(void (^)(NSError *))failure;

@end

//
//  WSProperty.m
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "WSProperty.h"

@implementation WSProperty

- (id)initWithUrl:(NSString *)url requestMethod:(RequestMethod)requestMethod
{
    return [self initWithUrl:url parameters:nil requestMethod:requestMethod];
}

- (id)initWithUrl:(NSString *)url parameters:(NSDictionary *)params requestMethod:(RequestMethod)requestMethod
{
    self = [super init];
    if (self) {
        self.url = url;
        self.parameters = params;
        self.requestMethod = requestMethod;
    }
    return self;
}

- (NSURL *)getUrl
{
    return [NSURL URLWithString:self.url];
}

- (NSString *)getRequestMethod
{
    NSString *requestedMethodString;
    switch (self.requestMethod) {
        case RequestMethodGet:
            requestedMethodString = @"GET";
            break;
        case RequestMethodPost:
            requestedMethodString = @"POST";
            break;
        case RequestMethodPut:
            requestedMethodString = @"PUT";
            break;
        case RequestMethodDelete:
            requestedMethodString = @"DELETE";
        default:
            break;
    }
    return requestedMethodString;
}

@end

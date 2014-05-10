//
//  WSProperty.h
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    RequestMethodGet,
    RequestMethodPost,
    RequestMethodPut,
    RequestMethodDelete
} RequestMethod;

@interface WSProperty : NSObject

@property (nonatomic, assign) RequestMethod requestMethod;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *parameters;

- (id)initWithUrl:(NSString *)url requestMethod:(RequestMethod) requestMethod;
- (id)initWithUrl:(NSString *)url parameters:(NSDictionary *)params requestMethod:(RequestMethod) requestMethod;
- (NSURL *) getUrl;
- (NSString *) getRequestMethod;

@end

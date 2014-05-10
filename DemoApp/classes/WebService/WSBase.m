//
//  WSBase.m
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "WSBase.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "Strings.h"

@interface WSBase()
{
    AFHTTPClient *httpClient;
    WSProperty *webServiceParams;
}
@end

@implementation WSBase

- (id)initWithParams:(WSProperty *)webServiceParameters
{
    return [self initWithParams:webServiceParameters andBaseUrlString:kBaseUrl];
}

- (id)initWithParams:(WSProperty *)webServiceParameters andBaseUrlString:(NSString *)baseUrlString
{
    self = [super init];
    if (self) {
        webServiceParams = webServiceParameters;
        NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrlString, [webServiceParams getUrl]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
        if ([baseUrlString isEqualToString:kBaseUrl]) {
            [httpClient setDefaultHeader:kBaseHeaderKey value:kBaseHeaderValue];
        }
    }
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:[webServiceParams getRequestMethod] path:nil parameters:[webServiceParams parameters]];
    self.urlString = [NSString stringWithFormat:@"%@", request];

    return self;
}

- (NSString *)getUrlString
{
    NSMutableURLRequest *request = [httpClient requestWithMethod:[webServiceParams getRequestMethod] path:nil parameters:[webServiceParams parameters]];
    return [NSString stringWithFormat:@"%@", request];
}

- (void)performRequestwithSuccess:(void (^)(NSDictionary *))success andFailure:(void (^)(NSError *))failure
{
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:[webServiceParams getRequestMethod] path:nil parameters:[webServiceParams parameters]];
    [request setTimeoutInterval:60];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         if (success) {
             success(JSON);
         }
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         if (failure) {
             failure(error);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No internet connection" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [alert show];
        }
     }];
    [operation start];
    
}



@end

//
//  Cache.h
//  DemoApp
//
//  Created by Alexandros on 10/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cache : NSManagedObject

@property (nonatomic, retain) NSString * cacheUrl;
@property (nonatomic, retain) NSData * cacheJson;
@property (nonatomic, retain) NSDate * cacheDate;

@end

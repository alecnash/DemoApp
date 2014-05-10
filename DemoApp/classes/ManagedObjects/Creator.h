//
//  Creator.h
//  DemoApp
//
//  Created by Alexandros on 10/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Board;

@interface Creator : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) Board *board;

@end

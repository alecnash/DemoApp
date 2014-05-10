//
//  Board.h
//  DemoApp
//
//  Created by Alexandros on 10/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Creator, Items;

@interface Board : NSManagedObject

@property (nonatomic, retain) NSString * coverImage;
@property (nonatomic, retain) Creator *creator;
@property (nonatomic, retain) Items *items;

@end

//
//  Items.h
//  DemoApp
//
//  Created by Alexandros on 10/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Board, Product;

@interface Items : NSManagedObject

@property (nonatomic, retain) Board *board;
@property (nonatomic, retain) Product *product;

@end

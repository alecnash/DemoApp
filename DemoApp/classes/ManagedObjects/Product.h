//
//  Product.h
//  DemoApp
//
//  Created by Alexandros on 10/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Items;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * shippingCost;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) Items *items;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end

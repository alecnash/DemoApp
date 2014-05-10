//
//  CollectionController.m
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionCell.h"
#import "CreatorCell.h"
#import "WSBase.h"
#import "Strings.h"
#import "UIColor.h"
#import "AppDelegate.h"

#import "Items.h"
#import "Board.h"
#import "Product.h"
#import "Image.h"
#import "Creator.h"
#import "Cache.h"


@interface CollectionController ()
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *itemArray;
    NSMutableDictionary *cacheDictionary;
    int lastPageLoaded;
}
@end

@implementation CollectionController

int const cacheMinutes = 15;

#pragma mark - lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    cacheDictionary = [[NSMutableDictionary alloc]init];
    lastPageLoaded = 0;
    itemArray = [[NSMutableArray alloc]init];
    [self.collectionView setBackgroundColor:[UIColor backgroundColor]];
    [self loadFromJsonForPage:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)loadFromJsonForPage:(int)page
{
    NSDictionary *parameters = @{@"gender": @"women",
                                 @"initializeBoards": @"true",
                                 @"pageItems": @"10",
                                 @"page": [NSString stringWithFormat:@"%d", page]
                                 };
    
    WSProperty *property = [[WSProperty alloc]initWithUrl:kUrlApiNews parameters:parameters requestMethod:RequestMethodGet];
    WSBase *base = [[WSBase alloc]initWithParams:property];
    Cache *cache = [self getCacheWithKey:[NSString stringWithFormat:@"%d", lastPageLoaded]];
    if (cache != nil) {
        NSDate *now = [NSDate new];
        NSDate *cached = cache.cacheDate;
        NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:cached];
        
        NSLog(@"timeinterval %f", distanceBetweenDates/60);
        if (distanceBetweenDates/60 < cacheMinutes) {
            NSDictionary *dict = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:cache.cacheJson];

            [self createItemsFromDict:dict];
            lastPageLoaded ++;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [self.collectionView reloadSections:indexSet];
        }
        else
            [self performNetworkRequestFromBase:base];
    }
    else {
        [self performNetworkRequestFromBase:base];
    }
}

- (void)performNetworkRequestFromBase:(WSBase *)base
{
    [base performRequestwithSuccess:^( NSDictionary *dict)
     {
         [self createItemsFromDict:dict];
         [self fillCacheFromDict:dict withKey:[NSString stringWithFormat:@"%d", lastPageLoaded]];
         lastPageLoaded ++;
         [self.collectionView reloadData];
         
     }
                         andFailure:^(NSError *error)
     {
         
     }];
}

//filling the cache and saving the object
- (void)fillCacheFromDict:(NSDictionary *)dict withKey:(NSString *)key
{
    NSData *cacheJson = [NSKeyedArchiver archivedDataWithRootObject:dict];
    NSDate *cacheDate = [NSDate new];
    NSDictionary *cacheString = @{@"cacheUrl": key,
                                  @"cacheJson":cacheJson,
                                  @"cacheDate": cacheDate};
    Cache *cache = (Cache *)[self objectFromDictionary:cacheString forName:@"cache"];
    NSError *error = nil;
    [managedObjectContext save:&error];
    [managedObjectContext refreshObject:cache mergeChanges:YES];
}

//Getting the cached object
- (Cache *)getCacheWithKey:(NSString *)key
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Cache" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cacheUrl ==[c] %@", key];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
    }
    Cache *cache = [array firstObject];
    return cache;
}

- (void)createItemsFromDict:(NSDictionary *)dict
{
    NSArray *itemsArray = [dict objectForKey:@"items"];
    
    if (itemsArray != (id)[NSNull null] && itemsArray != nil) {
        for (NSDictionary *itemsDict in itemsArray) {
            if ([itemsDict objectForKey:@"board"] != (id) [NSNull null])
                [self addBoardItemsFromDict:itemsDict];
            if ([itemsDict objectForKey:@"product"] != (id) [NSNull null])
                [self addProductItemsFromDict:itemsDict];
        }
    }
}

- (void)addBoardItemsFromDict:(NSDictionary *)itemsDict
{
    NSDictionary *boardDict = [itemsDict objectForKey:@"board"];
    NSDictionary *creatorDict = [boardDict objectForKey:@"creator"];
    Creator *creator = (Creator *)[self objectFromDictionary:creatorDict forName:@"creator"];
    Board *board = (Board *)[self objectFromDictionary:boardDict forName:@"board"];
    board.creator = creator;
    Items *items = (Items *)[self objectFromDictionary:itemsDict forName:@"items"];
    items.board = board;
    [itemArray addObject:items];
}

- (void)addProductItemsFromDict:(NSDictionary *)itemsDict
{
    NSDictionary *productDict = [itemsDict objectForKey:@"product"];
    NSArray *imagesArray = [productDict objectForKey:@"images"];
    Image *image;
    for (NSDictionary* imageDict in imagesArray) {
        image = (Image *)[self objectFromDictionary:imageDict forName:@"images"];
    }
    Product *product = (Product *)[self objectFromDictionary:productDict forName:@"product"];
    [product addImagesObject:image];
    Items *items = (Items *)[self objectFromDictionary:itemsDict forName:@"items"];
    items.product = product;
    [itemArray addObject:items];
}


- (NSManagedObject *)objectFromDictionary:(NSDictionary *)dict forName:(NSString *)name
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:name.capitalizedString
                                                            inManagedObjectContext:managedObjectContext];
    
    NSDictionary *attributes = [[NSEntityDescription entityForName:name.capitalizedString
                                            inManagedObjectContext:managedObjectContext] attributesByName];
    
    for (NSString *attr in attributes) {
        if ([dict valueForKey:attr] != (id)[NSNull null]) {
            [object setValue:[dict valueForKey:attr] forKey:attr];
        }
    }
    return object;
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSLog(@"itemsArray count %d", [itemArray count]);
    return [itemArray count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [itemArray count] - 3) {
        [self loadFromJsonForPage:lastPageLoaded];
    }
    UICollectionViewCell *returnCell;
    Items *item = itemArray[indexPath.row];
    if (item.product != nil) {
        CollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createCollectionCellFromModel:[itemArray objectAtIndex:indexPath.row]];
        returnCell = cell;
    }
    else {
        CreatorCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CreatorCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createCollectionCellFromModel:[itemArray objectAtIndex:indexPath.row]];
        returnCell = cell;
    }
    
    return returnCell;
}



- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 2, 50, 0);
}

@end

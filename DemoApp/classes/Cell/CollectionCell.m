//
//  CollectionCell.m
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "CollectionCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"
#import "UIColor.h"

#import "Items.h"
#import "Product.h"
#import "Image.h"

@implementation CollectionCell
@synthesize cellImage, cellNameLabel, cellPriceLabel, cellShippingCostLabel;

- (id)createCollectionCellFromModel:(id)model
{
    Items *items = (Items *)model;
    Product *productModel = items.product;
    
    if (productModel.name !=(id)[NSNull null])
        self.cellNameLabel.text = productModel.name;

    if (productModel.price !=(id)[NSNull null])
        self.cellPriceLabel.text = [productModel.price stringValue];

    [self setupShippingCostLabelWithModel:productModel];
    
    if ([productModel.images count] != 0) {
        for (Image *imageModel in productModel.images) {
            [self.cellImage setImageWithURL:[NSURL URLWithString:imageModel.url]
                           placeholderImage:[UIImage imageNamed:@"stylight.jpg"]];
        }
    }
    else
        self.cellImage.image = [UIImage imageNamed:@"stylight.jpg"];
    
    return self;
}

- (void)setupShippingCostLabelWithModel:(Product *)productModel
{
    self.cellShippingCostLabel.textColor = [UIColor textColorBeta];
    if (productModel.shippingCost !=(id)[NSNull null]) {
        if ([productModel.shippingCost isEqual:@0])
            self.cellShippingCostLabel.text = @"Versand: kostenlos";
        else
            self.cellShippingCostLabel.text = [NSString stringWithFormat:@"Versand: %@",
                                               [productModel.shippingCost stringValue]];
    }
    else
        self.cellShippingCostLabel.text = @"Kein Info";
}

@end

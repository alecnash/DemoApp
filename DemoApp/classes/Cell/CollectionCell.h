//
//  CollectionCell.h
//  DemoApp
//
//  Created by Alexandros on 08/05/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellShippingCostLabel;


- (id)createCollectionCellFromModel:(id)model;

@end

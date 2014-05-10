//
//  CreatorCell.h
//  DemoApp
//
//  Created by Alexandros Koutsonasios on 5/9/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatorCell : UICollectionViewCell

- (id)createCollectionCellFromModel:(id)model;

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

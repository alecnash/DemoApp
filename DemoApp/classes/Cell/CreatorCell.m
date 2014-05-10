//
//  CreatorCell.m
//  DemoApp
//
//  Created by Alexandros Koutsonasios on 5/9/14.
//  Copyright (c) 2014 Alexandros Koutsonasios. All rights reserved.
//

#import "CreatorCell.h"
#import "UIImageView+AFNetworking.h"

#import "Items.h"
#import "Board.h"
#import "Creator.h"

#import "Utils.h"
#import "UIColor.h"

@implementation CreatorCell
@synthesize nameLabel, picture, cityLabel, countryLabel, coverImage;

- (id)createCollectionCellFromModel:(id)model
{
    Items *item = (Items *)model;
    Board *board = item.board;
    Creator *creator = board.creator;
    
    [self setupNameLabelFromModel:creator];
    [self setupLocationLabel:self.cityLabel fromString:creator.city];
    [self setupLocationLabel:self.countryLabel fromString:creator.country];
    [self setupImageViews:coverImage fromString:board.coverImage];
    [self setupImageViews:picture fromString:creator.picture];
    return self;

}

- (void)setupNameLabelFromModel:(Creator *)creator
{
    NSString *name;
    if (creator.firstname !=(id)[NSNull null])
        name = creator.firstname;
    
    if (creator.lastname !=(id)[NSNull null])
        name = [name stringByAppendingFormat:@" %@", creator.lastname];
    
    if (name)
        self.nameLabel.text = name;
    else
        self.nameLabel.text = @"Unknown";
}

- (void)setupLocationLabel:(UILabel *)label fromString:(NSString *)string
{
    if (string !=(id)[NSNull null])
        label.text = string;
    else
        label.text = @"Unknown";
}

- (void)setupImageViews:(UIImageView *)imageView fromString:(NSString *)string
{
    if (string != (id)[NSNull null]) {
        NSString *imageString = [NSString stringWithFormat:@"http:%@", string];
        [imageView setImageWithURL:[NSURL URLWithString:imageString]
                        placeholderImage:[UIImage imageNamed:@"stylight.jpg"]];
    }
    else
        imageView.image = [UIImage imageNamed:@"stylight.jpg"];
}

@end

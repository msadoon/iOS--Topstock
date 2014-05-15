//
//  stockCell.m
//  topstock
//
//  Created by Farah Sadoon on 13-11-27.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import "stockCell.h"

@implementation stockCell

@synthesize name = _nameLabel;
@synthesize image = _image;
@synthesize points = _points;
@synthesize pcts = _pcts;
@synthesize symbol = _symbol;
@synthesize ltrade = _ltrade;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

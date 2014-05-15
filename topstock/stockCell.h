//
//  stockCell.h
//  topstock
//
//  Created by Farah Sadoon on 13-11-27.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stockCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UILabel *points;
@property (nonatomic, weak) IBOutlet UILabel *pcts;
@property (nonatomic, weak) IBOutlet UILabel *symbol;
@property (nonatomic, weak) IBOutlet UILabel *ltrade;
@end

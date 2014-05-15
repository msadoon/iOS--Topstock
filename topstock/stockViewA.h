//
//  stockViewA.h
//  topstock
//
//  Created by Farah Sadoon on 13-12-01.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Stock, headlines;

@interface stockViewA : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UILabel *symbol;
@property (nonatomic, retain) IBOutlet UILabel *points;
@property (nonatomic, retain) IBOutlet UILabel *percent;
@property (nonatomic, retain) IBOutlet UILabel *lastTrade;
@property (nonatomic, retain) IBOutlet UILabel *pcValue;
@property (nonatomic, retain) IBOutlet UILabel *oValue;
@property (nonatomic, retain) IBOutlet UILabel *bValue;
@property (nonatomic, retain) IBOutlet UILabel *aValue;
@property (nonatomic, retain) IBOutlet UILabel *teValue;
@property (nonatomic, retain) IBOutlet UILabel *beValue;
@property (nonatomic, retain) IBOutlet UILabel *nedValue;
@property (nonatomic, retain) IBOutlet UILabel *drValue;
@property (nonatomic, retain) IBOutlet UILabel *rValue;
@property (nonatomic, retain) IBOutlet UILabel *vValue;
@property (nonatomic, retain) IBOutlet UILabel *avValue;
@property (nonatomic, retain) IBOutlet UILabel *mcValue;
@property (nonatomic, retain) IBOutlet UILabel *peValue;
@property (nonatomic, retain) IBOutlet UILabel *epsValue;
@property (nonatomic, retain) IBOutlet UILabel *dyValue;
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, retain) IBOutlet UIImageView *chart;
@property (nonatomic, retain) IBOutlet UIScrollView *display;
@property (nonatomic, strong) Stock *placeHolder;
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) headlines *h1;
- (void) updateInfo;
@end

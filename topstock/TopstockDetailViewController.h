//
//  TopstockDetailViewController.h
//  topstock
//
//  Created by Farah Sadoon on 13-11-16.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class stockViewA;

@interface TopstockDetailViewController : UITableViewController
{
    NSThread *BackgroundThread;
}
@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSString *market;
@property (nonatomic, strong) stockViewA *stockDetail;
-(void)loadLosers;
-(void)loadGainers;
@property BOOL runningOp;
@end

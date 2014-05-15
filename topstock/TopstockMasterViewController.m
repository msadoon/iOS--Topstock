//
//  TopstockMasterViewController.m
//  topstock
//
//  Created by Farah Sadoon on 13-11-16.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import "TopstockMasterViewController.h"
#import "MBProgressHUD.h"
#import "TopstockDetailViewController.h"

#import "TFHpple.h"
#import "Stock.h"

@interface TopstockMasterViewController () {
    NSMutableArray *_objects;
    //NSMutableArray *_contributors;
    BOOL doneListing;
    //BOOL keepChecking;
}
@end

@implementation TopstockMasterViewController
//tutorial working...let's try the same code but substitute in ca.finance.yahoo into xpath...

//
//-(void) loadContributors {
//    //1
//    NSURL *contributorsUrl = [NSURL URLWithString:@"http://www.raywenderlich.com/about"];
//    NSData *contributorsHtmlData = [NSData dataWithContentsOfURL:contributorsUrl];
//    
//    //2
//    TFHpple *contributorsParser = [TFHpple hppleWithHTMLData:contributorsHtmlData];
//    
//    //3
//    NSString *contributorsXpathQueryString = @"//ul[@class='team-members']/li";
//    NSArray *contributorsNodes = [contributorsParser searchWithXPathQuery:contributorsXpathQueryString];
//    
//    //4
//    NSMutableArray *newContributors = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in contributorsNodes){
//        //5
//        Contributor *contributor= [[Contributor alloc] init];
//        [newContributors addObject:contributor];
//        
//        //6
//        for (TFHppleElement *child in element.children) {
//            //NSLog(@"%@", child.firstChild.tagName);
//            if ([child.firstChild.tagName isEqualToString:@"img"]){
//                //7
//                @try {
//                    contributor.imageURL = [@"" stringByAppendingString:[child.firstChild objectForKey:@"src"]];
//                    //NSLog(@"%@", contributor.imageURL);
//                }
//                                            @catch (NSException *e) {}
//                                            } if ([child.tagName isEqualToString:@"h3"]){
//                                                //8
//                                                contributor.name = [[child firstChild] content];
//                                            }
//                                            
//                                            
//                }
//            }
//        
//                                            
//                                            _contributors = newContributors;
//                                            [self.tableView reloadData];
//    
//    
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //NSLog(@"call initWithNibName");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Topstock", @"Topstock");
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Markets" style:UIBarButtonItemStyleBordered target:nil action:nil];
    }
    
    return self;
}
							
- (void)viewDidLoad
{
    //NSLog(@"call viewDidLoad");
    [super viewDidLoad];
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [self insertNewObject:@"TSX"];
    [self insertNewObject:@"TSX Venture"];
    [self insertNewObject:@"US"];
    [self insertNewObject:@"NASDAQ"];
    [self insertNewObject:@"AMEX"];
    [self insertNewObject:@"NYSE"];
}

- (void)didReceiveMemoryWarning
{
    //NSLog(@"call didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(NSString *)sender
{
    
   // NSLog(@"call insertNewObject");
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:sender atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"call numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //switch(section) {
        //case 0:
    //NSLog(@"call numberOfRowsInSection");
            return _objects.count;
            //break;
        //case 1:
            //return _contributors.count;
            //break;
    //}
    //return 0;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //switch(section) {
        //case 0:
    //NSLog(@"call titleForHeaderInSection");
            return @"Market";
            //break;
        //case 1:
            //return @"Contributors";
            //break;
    //}
    //return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"call cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if (indexPath.section == 0){
    
        //Tutorial *thisTutorial = [_objects objectAtIndex:indexPath.row];
        cell.textLabel.text = [_objects objectAtIndex:indexPath.row];
        //cell.textLabel.text = [thisTutorial.name] + [@" %s ", [thisTutorial.points ]] + [@" %s ", [thisTutorial.pct]]);
        //cell.detailTextLabel.text = thisTutorial.symbol + [@" %@ ", [thisTutorial.ltrade]] + [@" %@ ", [thisTutorial.volume]];
    }
    //else if (indexPath.section == 1) {
    //    Contributor *thisContributor = [_contributors objectAtIndex:indexPath.row];
    //    cell.textLabel.text = thisContributor.name;
    //    cell.detailTextLabel.text = thisContributor.imageURL;
    //}
    
    //NSDate *object = _objects[indexPath.row];
    //cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"call canEditRowAtIndexPath");
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"call commitEditingStyle");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void) runListing: (TopstockDetailViewController *) viewController
{
    NSLog(@"run listing start");
    doneListing = NO;
    [viewController loadGainers];
    [viewController loadLosers];
    [viewController.tableView reloadData];
    //[viewController.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    //keepChecking = NO;
    NSLog(@"run listing complete");
    doneListing = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"call didSelectRowAtIndexPath");
    if (!self.detailViewController) {
        self.detailViewController = [[TopstockDetailViewController alloc] initWithNibName:@"TopstockDetailViewController" bundle:nil];
    }
    NSString *object = _objects[indexPath.row];
    //[object isEqualToString:@"TSX"];
    if ([object isEqualToString: @"TSX"]){
        self.detailViewController.market = @"TO";
        [self.detailViewController setDetailItem:self.detailViewController.market];
        //NSLog(@"%@", self.detailViewController.market);
    }else if ([object isEqualToString: @"TSX Venture"]){
        self.detailViewController.market = @"V";
         [self.detailViewController setDetailItem:self.detailViewController.market];
        //NSLog(@"%@", self.detailViewController.market);
    }else if ([object isEqualToString: @"NASDAQ"]){
        self.detailViewController.market = @"O";
         [self.detailViewController setDetailItem:self.detailViewController.market];
        //NSLog(@"%@", self.detailViewController.market);
    }else if ([object isEqualToString: @"US"]){
        self.detailViewController.market = @"US";
         [self.detailViewController setDetailItem:self.detailViewController.market];
        //NSLog(@"%@", self.detailViewController.market);
    } else if ([object isEqualToString: @"AMEX"]){
        self.detailViewController.market = @"AQ";
         [self.detailViewController setDetailItem:self.detailViewController.market];
        //NSLog(@"%@", self.detailViewController.market);
    }else {
        self.detailViewController.market = @"NQ";
         [self.detailViewController setDetailItem:self.detailViewController.market];
        //NSLog(@"%@", self.detailViewController.market);
    }
    
    //while(true){
       //if (self.detailViewController.isViewLoaded) {
    
           //break;
       //}
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSOperationQueue *queue = [NSOperationQueue new];
        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runListing:) object:self.detailViewController];
        
        [queue addOperation: operation];
        //keepChecking = YES;
        while (true)
        {
            if (operation.isFinished){
                //doneListing = doneListing;
                if (doneListing){
                    NSLog(@"should switch views");
                    [self.navigationController performSelectorOnMainThread:@selector(pushViewController:animated:) withObject:self.detailViewController waitUntilDone:YES];
                
                    doneListing = NO;
                    //keepChecking = NO;
                    break;
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{[MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    //while (true){
        //NSLog(@"looping");
        //if (doneListing == YES){
        
            //[self.navigationController performSelector:@selector(pushViewController:animated:) withObject:self.detailViewController afterDelay: 0.0 ];
            //break;
        //}
    //}
    //}
    
    
}

@end

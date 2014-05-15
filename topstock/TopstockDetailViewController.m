//
//  TopstockDetailViewController.m
//  topstock
//
//  Created by Farah Sadoon on 13-11-16.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import "TopstockDetailViewController.h"
#import "TFHpple.h"
#import "Stock.h"
#import "stockCell.h"
#import "stockViewA.h"
#import "MBProgressHUD.h"

@interface TopstockDetailViewController ()
{
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    NSArray *gainersNameNodes;
    NSArray *gainersPtsNodes;
    NSArray *gainersSymbolNodes;
    NSArray *gainersVolNodes;
    NSArray *gainersLTradeNodes;
    NSArray *losersNameNodes;
    NSArray *losersPtsNodes;
    NSArray *losersSymbolNodes;
    NSArray *losersVolNodes;
    NSArray *losersLTradeNodes;
    BOOL doneListing;
    UIBarButtonItem *updateButton;
    //MBProgressHUD *hud;
    //BOOL runningOp;
    //UIImage *thumbs;
    //UIImageView *thumbsview;
    //CGFloat width;
}
@end

@implementation TopstockDetailViewController

@synthesize market;
@synthesize runningOp;

#pragma mark - Managing the detail item
//

-(void)loadGainers {
    [self unloadGainers];
    //sleep(5);
    int count = 0;
    int count2 = 0;
    //1
    NSMutableString *marketURL = [[NSMutableString alloc] initWithString: @"http://ca.finance.yahoo.com/gainers?e="];
    
    [marketURL appendString:market];
    //NSLog(@"%@", marketURL);
    NSURL *gainersUrl = [NSURL URLWithString: marketURL];
    NSData *gainersHtmlData = [NSData dataWithContentsOfURL: gainersUrl];
    //NSString *a = [[NSString alloc] initWithData:gainersHtmlData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", a);
    //2
    TFHpple *gainersParser = [TFHpple hppleWithHTMLData:gainersHtmlData];
    //NSLog(@"%@", [gainersParser description]);
    //3
    
    NSString *gainersXpathQueryString = @"//tbody/tr/td[@class='second name']";
    gainersNameNodes = [gainersParser searchWithXPathQuery: gainersXpathQueryString];
    NSString *gainersXpathQueryString2 = @"//tbody/tr/td/span/b";
    gainersPtsNodes = [gainersParser searchWithXPathQuery: gainersXpathQueryString2];
    NSString *gainersXpathQueryString3 = @"//tbody/tr/td/b/a";
    gainersSymbolNodes = [gainersParser searchWithXPathQuery: gainersXpathQueryString3];
    NSString *gainersXpathQueryString4 = @"//tbody/tr/td/span";
    gainersVolNodes = [gainersParser searchWithXPathQuery: gainersXpathQueryString4];
    NSString *gainersXpathQueryString5 = @"//tbody/tr/td/nobr/span";
    gainersLTradeNodes = [gainersParser searchWithXPathQuery: gainersXpathQueryString5];
    //4
    NSMutableArray *newGainers = [[NSMutableArray alloc] initWithCapacity:0];
    //for (int i=0;i<5;i++){
    //NAMES
    for (TFHppleElement *element in gainersNameNodes) {
        
        Stock *gainer = [[Stock alloc] init];
        [newGainers addObject: gainer];
        count++;
        gainer.name = [element.firstChild content];
            if (count == 5){
                break;
            }
        
    }
    
    count = 0;
    //SYMBOLS
    for (TFHppleElement *element in gainersSymbolNodes) {
        [[newGainers objectAtIndex:count] setSymbol: [element.firstChild content]];
        count++;
        if (count == 5){
            break;
        }
    }

    count = 0;
    //PTS & PCT
    for (TFHppleElement *element in gainersPtsNodes) {
        //NSLog(@"%@", element.tagName);
        //[[newGainers objectAtIndex:count] setImg_url:[element objectForKey:@"src"]];
        if (count == 0 || count == 2 || count == 4 || count == 6 || count == 8 ){
            [[newGainers objectAtIndex:count2] setPoints: [element.firstChild content]];
        } else {
            [[newGainers objectAtIndex:count2] setPct: [element.firstChild content]];
            count2++;
        }
        count++;
        if (count == 10){
            break;
        }
    }
    count = 0;
    count2 = 0;
    //VOLUME
    for (TFHppleElement *element in gainersVolNodes) {
        //NSLog(@"%@", [element.firstChild content]);
        //[[newGainers objectAtIndex:count] setImg_url:[element objectForKey:@"src"]];
        if ((count == 2) || (count ==5) || (count ==8) || (count ==11) || (count ==14)){
            [[newGainers objectAtIndex:count2] setVolume: [element.firstChild content]];
            count2++;
        }
        count++;
        if (count == 15){
            break;
        }
    }
    
    count = 0;
    //LAST_TRADE
    for (TFHppleElement *element in gainersLTradeNodes) {
        //NSLog(@"%@", element.tagName);
        //[[newGainers objectAtIndex:count] setImg_url:[element objectForKey:@"src"]];
        [[newGainers objectAtIndex:count] setLtrade: [element.firstChild content]];
        count++;
        if (count == 5){
            break;
        }
    }
    
    //8
    _objects = newGainers;
    
    
}

-(void)unloadGainers{
    //NSLog(@"call unloadGainers");
    gainersNameNodes = [[NSArray alloc] init];
    gainersSymbolNodes = [[NSArray alloc] init];
    gainersPtsNodes = [[NSArray alloc] init];
    gainersLTradeNodes = [[NSArray alloc] init];
    gainersVolNodes = [[NSArray alloc] init];
    _objects = [[NSMutableArray alloc] init];
}

-(void)loadLosers {
    [self unloadLosers];
    int count = 0;
    int count2 = 0;
    //1
    NSMutableString *marketURL = [[NSMutableString alloc] initWithString: @"http://ca.finance.yahoo.com/losers?e="];
    
    [marketURL appendString:market];
    // NSLog(@"%@", marketURL);
    NSURL *losersUrl = [NSURL URLWithString: marketURL];
    NSData *losersHtmlData = [NSData dataWithContentsOfURL: losersUrl];
    //NSString *a = [[NSString alloc] initWithData:gainersHtmlData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", a);
    //2
    TFHpple *losersParser = [TFHpple hppleWithHTMLData:losersHtmlData];
    //NSLog(@"%@", [gainersParser description]);
    //3
    NSString *losersXpathQueryString = @"//tbody/tr/td[@class='second name']";
    losersNameNodes = [losersParser searchWithXPathQuery: losersXpathQueryString];
    NSString *losersXpathQueryString2 = @"//tbody/tr/td/span/b";
    losersPtsNodes = [losersParser searchWithXPathQuery: losersXpathQueryString2];
    NSString *losersXpathQueryString3 = @"//tbody/tr/td/b/a";
    losersSymbolNodes = [losersParser searchWithXPathQuery: losersXpathQueryString3];
    NSString *losersXpathQueryString4 = @"//tbody/tr/td/span";
    losersVolNodes = [losersParser searchWithXPathQuery: losersXpathQueryString4];
    NSString *losersXpathQueryString5 = @"//tbody/tr/td/nobr/span";
    losersLTradeNodes = [losersParser searchWithXPathQuery: losersXpathQueryString5];
    //4
    
    NSMutableArray *newLosers = [[NSMutableArray alloc] initWithCapacity:0];
    //for (int i=0;i<5;i++){
    //NAMES
    for (TFHppleElement *element in losersNameNodes) {
        
        Stock *loser = [[Stock alloc] init];
        [newLosers addObject: loser];
        count++;
        loser.name = [element.firstChild content];
        if (count == 5){
            //NSLog(@"Breaks names");
            break;
            
        }
        
    }
    
    count = 0;
    //SYMBOLS
    for (TFHppleElement *element in losersSymbolNodes) {
        [[newLosers objectAtIndex:count] setSymbol: [element.firstChild content]];
        count++;
        if (count == 5){
            //NSLog(@"Breaks symbols");
            break;
            
        }
    }
    
    count = 0;
    //PTS & PCT
    for (TFHppleElement *element in losersPtsNodes) {
        //NSLog(@"%@", element.tagName);
        //[[newGainers objectAtIndex:count] setImg_url:[element objectForKey:@"src"]];
        if (count == 0 || count == 2 || count == 4 || count == 6 || count == 8 ){
            [[newLosers objectAtIndex:count2] setPoints: [element.firstChild content]];
        } else {
            [[newLosers objectAtIndex:count2] setPct: [element.firstChild content]];
            count2++;
        }
        count++;
        if (count == 10){
            //NSLog(@"Breaks pts and pct");
            break;
        }
    }
    count = 0;
    count2 = 0;
    //VOLUME
    for (TFHppleElement *element in losersVolNodes) {

        if ((count == 2) || (count ==5) || (count ==8) || (count ==11) || (count ==14)){
            [[newLosers objectAtIndex:count2] setVolume: [element.firstChild content]];
            count2++;
        }
        count++;
        if (count == 15){
            //NSLog(@"Breaks volume");
            break;
        }
    }
    
    count = 0;
    //LAST_TRADE
    for (TFHppleElement *element in losersLTradeNodes) {

        [[newLosers objectAtIndex:count] setLtrade: [element.firstChild content]];
        count++;
        if (count == 5){
            //NSLog(@"Breaks ltrade");
            break;
        }
    }
    
    //8
    _objects2 = newLosers;

    
    
}

-(void)unloadLosers{
     //NSLog(@"call unloadLosers");
    losersNameNodes = [[NSArray alloc] init];
    losersSymbolNodes = [[NSArray alloc] init];
    losersPtsNodes = [[NSArray alloc] init];
    losersLTradeNodes = [[NSArray alloc] init];
    losersVolNodes = [[NSArray alloc] init];
    _objects2 =[[NSMutableArray alloc] init];
    //NSLog(@"Clear out losers");
}

- (void) update
{
    NSLog(@"%d", runningOp);
   if (runningOp){
       
       self.navigationItem.rightBarButtonItem.enabled = NO;
        runningOp = false;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01* NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self loadGainers];
            [self loadLosers];
            [self.tableView reloadData];
            runningOp = true;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.navigationItem.rightBarButtonItem.enabled = YES;
        });
    }
}

- (void)setDetailItem:(id)newDetailItem
{
    
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
    if (self) {
        //NSLog(@"%@",[self market]);
        if ([market isEqualToString:@"O"]){
            self.title = NSLocalizedString(@"NASDAQ", @"NASDAQ");
        }
        else if ([market isEqualToString:@"TO"]){
            self.title = NSLocalizedString(@"TSX", @"TSX");
        }
        else if ([market isEqualToString:@"V"]){
            self.title = NSLocalizedString(@"TSX Venture", @"TSX Venture");
        }
        else if ([market isEqualToString:@"AQ"]){
            self.title = NSLocalizedString(@"AMEX", @"AMEX");
        }
        else if ([market isEqualToString:@"US"]){
            self.title = NSLocalizedString(@"US", @"US");
        }else {
            self.title = NSLocalizedString(@"NYSE", @"NYSE");
        }
    }


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // NSLog(@"call tableView");
    return _objects.count;
    //break;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"call numberOfSectionsInTableView");
     //NSLog(@"call numberOfSectionsInTableView");
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //NSLog(@"set the title for header section");
     //NSLog(@"call titleForHeaderInSection");
    switch(section) {
    case 0:
    //NSLog(@"call titleForHeaderInSection");
            return @"Top 5 Gainers";
    break;
    case 1:
            return @"Top 5 Losers";
    break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"call tableView cellForRowAtIndexPath");
    if (indexPath.section == 0){
        //[self loadGainers];
        //[self.tableView reloadData];
        static NSString *stockCellIdentifier = @"stockCell";
        
        stockCell *cell = (stockCell *)[tableView dequeueReusableCellWithIdentifier:stockCellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"stockCell" owner: self options: nil];
            cell = [nib objectAtIndex:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (_objects.count > 0){
            Stock *thisStock = [_objects objectAtIndex:indexPath.row];
            cell.symbol.text = thisStock.symbol;
            cell.name.text = thisStock.name;
            cell.ltrade.text = thisStock.ltrade;
            cell.points.text = thisStock.points;
            cell.pcts.text = thisStock.pct;
            cell.image.image = [UIImage imageNamed:@"up_g.gif"];
            cell.pcts.textColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
            cell.points.textColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
        }
        //NSLog(@"Stop loading");
        return cell;
    } else if (indexPath.section == 1){
        //[self loadLosers];
        //[self.tableView reloadData];
        
        static NSString *stockCellIdentifier = @"stockCell";
        
        stockCell *cell = (stockCell *)[tableView dequeueReusableCellWithIdentifier:stockCellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"stockCell" owner: self options: nil];
            cell = [nib objectAtIndex:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (_objects2.count > 0){
            Stock *thisStock = [_objects2 objectAtIndex:indexPath.row];
            cell.symbol.text = thisStock.symbol;
            cell.name.text = thisStock.name;
            cell.ltrade.text = thisStock.ltrade;
            cell.points.text = thisStock.points;
            cell.pcts.text = thisStock.pct;
            cell.image.image = [UIImage imageNamed:@"down_r.gif"];
            cell.pcts.textColor = [UIColor redColor];
            cell.points.textColor = [UIColor redColor];
        }
        //NSLog(@"Stop loading");
        return cell;
    }
   
    
    return nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    //NSLog(@"view appears");
    //NSLog(@"runs ");
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    runningOp = true;
    NSLog(@"viewWillAppear");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollsToTop = YES;
    updateButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(update)];
    
    self.navigationItem.rightBarButtonItem = updateButton;
    //runningOp = YES;
    NSLog(@"viewDidLoad");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //[self setDoneLoading: NO];
        return self;
}
-(void) runListing: (stockViewA *) stockdetails
{
    doneListing = NO;
    //[stockdetails createLabels];
    [stockdetails updateInfo];
    doneListing = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!self.stockDetail) {
        self.stockDetail = [[stockViewA alloc] init];
    }
    //NSLog(@"Runs didSelectRowAIndexPath");
    
    //Stock *tempStock = [[Stock alloc] init];
    if (indexPath.section == 0){
        if (_objects.count > 0){
            self.stockDetail.placeHolder = _objects[indexPath.row];
            NSLog(@"%@", self.stockDetail.placeHolder.name);
            self.stockDetail.section = @"One";
        }
        //NSLog(@"Runs first if");
    } else {
        if (_objects2.count > 0){
            self.stockDetail.placeHolder = _objects2[indexPath.row];
            NSLog(@"%@", self.stockDetail.placeHolder.name);
            self.stockDetail.section = @"Two";
        }
        //NSLog(@"Runs else");
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSOperationQueue *queue = [NSOperationQueue new];
        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runListing:) object:self.stockDetail];
        
        [queue addOperation: operation];
        while (true)
        {
            
            if (operation.isFinished){//NSLog(@"done Listing: %i", doneListing);
                if (doneListing ==YES){
                    NSLog(@"should switch views");
                    [self.navigationController performSelectorOnMainThread:@selector(pushViewController:animated:) withObject:self.stockDetail waitUntilDone:YES];
                
                    doneListing = NO;
                    break;
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{[MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.navigationController pushViewController:self.stockDetail animated:YES];
}


@end

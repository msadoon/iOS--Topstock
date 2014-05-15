//
//  stockViewA.m
//  topstock
//
//  Created by Farah Sadoon on 13-12-01.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import "stockViewA.h"
#import "TFHpple.h"
#import "Stock.h"
#import "headlines.h"
#import "MBProgressHUD.h"

@implementation stockViewA
{
    NSArray *quotesNodes;
    NSArray *quotes2Nodes;
    NSArray *quotes3Nodes;
    NSArray *quotes4Nodes;
    NSArray *quotes5Nodes;
    NSMutableDictionary *labelValues;
    UIWebView *news2;
    BOOL runningOp;
    NSOperationQueue *queue;
    UIImage *chartImgTemp;
    UIImage *iconImgTemp;
    UIColor *percColor;
    UIColor *poiColor;
    //NSOperationQueue *queue;
    //headlines *h1;
}
@synthesize name;
@synthesize price;
@synthesize symbol;
@synthesize points;
@synthesize percent;
@synthesize lastTrade;
@synthesize pcValue;
@synthesize oValue;
@synthesize bValue;
@synthesize aValue;
@synthesize teValue;
@synthesize beValue;
@synthesize nedValue;
@synthesize drValue;
@synthesize rValue;
@synthesize vValue;
@synthesize avValue;
@synthesize mcValue;
@synthesize peValue;
@synthesize epsValue;
@synthesize dyValue;
@synthesize icon;
@synthesize chart;
@synthesize placeHolder;
@synthesize section;
@synthesize h1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //runningOp = true;
    //[self.display setDelegate:self];
    return self;
}

-(void) viewWillAppear:(BOOL) animated
{
    //[self readYahooFinance];
    //[self updateInfo];
    [self updateLabelsOnScreen];
    //NSLog(@"viewWillAppear");
    //[self reloadInputViews];
}
/*
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"contentOffset %f", scrollView.contentOffset.y);
    //NSLog(@"contentOffset %i", runningOp);
    if (queue.operations.count ==0)
 
    else
        runningOp = false;
    if (scrollView.contentOffset.y < 0 && runningOp){
        queue = [NSOperationQueue new];
        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(updateInfo) object:nil];
        
        [queue addOperation: operation];
        //NSLog(@"Queue up operation 2");
        
    }
    
}

*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    UIBarButtonItem *headlinesButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(gotoHeadlines)];
    UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                     UIBarButtonSystemItemRefresh target:self action:@selector(update)];
    
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:headlinesButton, updateButton, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
    //[self createLabels];
    //self.navigationItem.rightBarButtonItem.title = @"+";
    //NSMutableArray *displayObjects = [[NSMutableArray alloc] init];
    //[self updateInfo];
    runningOp = YES;
    
}

- (void) update
{
    
    if (runningOp){
        UIBarButtonItem *one = self.navigationItem.rightBarButtonItems[0];
        UIBarButtonItem *two = self.navigationItem.rightBarButtonItems[1];
        one.enabled = NO;
        two.enabled = NO;
        runningOp = false;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01* NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self updateInfo];
            [self updateLabelsOnScreen];
            runningOp = true;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            one.enabled = YES;
            two.enabled = YES;
        });
    }
}

-(void) createLabels
{
    labelValues = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"name.text", @"name.text1", @"symbol.text", @"symbol.text1", @"price.text", @"price.text1", @"points.text", @"points.text1", @"percent.text", @"percent.text1", @"lasttrade.text", @"lasttrade.text1", @"pcValue.text", @"pcValue.text1", @"oValue.text", @"oValue.text1", @"bValue.text", @"bValue.text1", @"aValue.text", @"aValue.text1", @"teValue.text", @"teValue.text1", @"beValue.text", @"beValue.text1", @"nedValue.text", @"nedValue.text1", @"drValue.text", @"drValue.text1", @"rValue.text", @"rValue.text1", @"vValue.text", @"vValue.text1", @"avValue.text", @"avValue.text1", @"mcValue.text", @"mcValue.text1", @"peValue.text", @"peValue.text1", @"epsValue.text", @"epsValue.text1", @"dyValue.text", @"dyValue.text1", nil];
}

-(BOOL) checkLoaded
{
    while (true){
        if (self.h1.loaded == true){
            break;
        }
    }
    return self.h1.loaded;
}

-(void) gotoHeadlines {
    h1 = [[headlines alloc] init];
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://m.yahoo.com/w/legobpengine/finance/details/?.market_view=market_related_content_more&.b=details%2F%3F.b%3Dindex&.sy="];
    [url appendString:placeHolder.symbol];
    [url appendString:@"&.ts=1386695501&.intl=ca&.lang=en-ca"];
    
    [h1 loadPage:url];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self.h1 selector:@selector(checkLoaded) object:nil];
        [queue addOperation: operation];
        
        [self.navigationController performSelectorOnMainThread:@selector(pushViewController:animated:) withObject:self.h1 waitUntilDone:YES];
        dispatch_async(dispatch_get_main_queue(), ^{[MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    //
    
    //

}

-(void) readYahooFinance
{
        [self createLabels];
        if (placeHolder.name != nil)
            [labelValues setObject:placeHolder.name forKey:@"name.text1"];
        else
            [labelValues setObject:@"N/A" forKey:@"name.text1"];
        if (placeHolder.symbol != nil)
            [labelValues setObject:placeHolder.symbol forKey:@"symbol.text1"];
        else
            [labelValues setObject:@"N/A" forKey:@"symbol.text1"];
        //symbol.text = placeHolder.symbol;
        if ([section isEqualToString:@"Two"]){
            iconImgTemp = [UIImage imageNamed:@"down_r.gif"];
            //icon.image = ;
            poiColor = [UIColor redColor];
            percColor = [UIColor redColor];
        } else
        {
            iconImgTemp = [UIImage imageNamed:@"up_g.gif"];
            percColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
            poiColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
        }
        //[self unloadLosers];
        int count = 0;
        int count2 = 0;
        //1
        NSMutableString *marketURL = [[NSMutableString alloc] initWithString: @"http://ca.finance.yahoo.com/q?s="];
        NSMutableString *drValue1 = [[NSMutableString alloc] initWithString:@""];
        NSMutableString *rValue1 = [[NSMutableString alloc] initWithString:@""];
        [marketURL appendString: [placeHolder symbol]];
        NSURL *quoteUrl = [NSURL URLWithString: marketURL];
        NSData *quoteHtmlData = [NSData dataWithContentsOfURL: quoteUrl];
        //2
        TFHpple *quoteParser = [TFHpple hppleWithHTMLData:quoteHtmlData];
        //3
        NSString *quoteXpathQueryString = @"//body/div[@id='yfi_doc']/div[@id='yfi_bd']/div[@id='yfi_investing_content']/div[@class='yui-u first yfi-start-content']/div[@class='yfi_quote_summary']/div[@id='yfi_quote_summary_data'][@class='rtq_table']/table/tr/td";
        quotesNodes = [quoteParser searchWithXPathQuery: quoteXpathQueryString];
        NSString *quote2XpathQueryString = @"//*[@class='yfi_rt_quote_summary_rt_top sigfig_promo_0']/div/span[@class='time_rtq_ticker']/span";
        quotes2Nodes = [quoteParser searchWithXPathQuery: quote2XpathQueryString];
        NSString *quote3XpathQueryString = @"//*[@id='yfi_summary_chart']/div/a";
        quotes3Nodes = [quoteParser searchWithXPathQuery: quote3XpathQueryString];
        NSString *quote4XpathQueryString = @"//*[@class='yfi_rt_quote_summary_rt_top sigfig_promo_0']/div/span[2]";
        quotes4Nodes = [quoteParser searchWithXPathQuery: quote4XpathQueryString];
        NSString *quote5XpathQueryString = @"//*[@class='yfi_rt_quote_summary_rt_top sigfig_promo_0']/div/span[3]";
        quotes5Nodes = [quoteParser searchWithXPathQuery: quote5XpathQueryString];
        //4
    
        //get chart
        for (TFHppleElement *element in quotes3Nodes){
            //NSLog(@"%@", [element.firstChild objectForKey:@"src"]);
            if ([element.firstChild.tagName isEqualToString:@"img"])
                @try {
                    chartImgTemp = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[element.firstChild objectForKey:@"src"]]]];
                }
            @catch (NSException *exception) {
            }
        }
        //get price
    
        for (TFHppleElement *element in quotes2Nodes){
            if (element.text != nil)
            [labelValues setObject:element.text forKey:@"price.text1"];
            else
                [labelValues setObject:@"N/A" forKey:@"price.text1"];
        }
        
        //get pct and points
        //NSLog(@"quotes4Notes length %i", quotes4Nodes.count);
        for (TFHppleElement *element in quotes4Nodes){
            for (TFHppleElement *childA in element.children){
                count2++;
                for (TFHppleElement *childB in childA.children){
                    if (count2 == 1) {
                        if (childB.content != nil)
                            [labelValues setObject:childB.content forKey:@"points.text1"];
                        //points.text = childB.content;
                    } else {
                        if (childB.content != nil)
                        [labelValues setObject:childB.content forKey:@"percent.text1"];
                        else
                            [labelValues setObject:@"N/A" forKey:@"percent.text1"];
                        //percent.text = childB.content;
                    }
                }
            }
        }
        count2 = 0;
        //get last trade
        for (TFHppleElement *element in quotes5Nodes){
            count2++;
            for (TFHppleElement *childA in element.children){
                if (count2 == 1){
                   // NSLog(@"last trade: %@", childA.firstChild.text);
                    if (childA.firstChild.content != nil){
                        [labelValues setObject:childA.firstChild.content forKey:@"lasttrade.text1"];
                    }else if (childA.firstChild.text != nil){
                        [labelValues setObject:childA.firstChild.text forKey:@"lasttrade.text1"];
                    }
                    else {
                        [labelValues setObject:@"N/A" forKey:@"lasttrade.text1"];
                    }
                    //lastTrade.text = childA.firstChild.text;
                }
            }
        }
        count2 = 0;
        for (TFHppleElement *element in quotesNodes) {
            if (count == 0){
                if (element.text != nil)
                    [labelValues setObject:element.text forKey:@"pcValue.text1"];
                else
                    [labelValues setObject:@"N/A" forKey:@"pcValue.text1"];
               //pcValue.text = element.text;
            }
            else if (count ==1){
               if (element.text != nil)
                   [labelValues setObject:element.text forKey:@"oValue.text1"];
               //oValue.text = element.text;
               else
                   [labelValues setObject:@"N/A" forKey:@"oValue.text1"];
                }
           else if (count ==2){
               if (element.text != nil){
                   if ([element.text isEqualToString:@"N/A"])
                       [labelValues setObject:element.text forKey:@"bValue.text1"];
                   //bValue.text = element.text;
                   } else{
                       if (element.firstChild.text != nil)
                           [labelValues setObject:element.firstChild.text forKey:@"bValue.text1"];
                       else
                           [labelValues setObject:@"N/A" forKey:@"bValue.text1"];
                   //bValue.text = element.firstChild.text;
                   }
               
           }
           else if (count ==3){
               if ([element.text isEqualToString:@"N/A"]){
                   [labelValues setObject:element.text forKey:@"aValue.text1"];
                   //aValue.text = element.text;
               } else{
                   if (element.firstChild.text != nil){
                       [labelValues setObject:element.firstChild.text forKey:@"aValue.text1"];
                   }
                   else
                       [labelValues setObject:@"N/A" forKey:@"aValue.text1"];
                   //aValue.text = element.firstChild.text;
               }
           }
           else if (count ==4){
               if (element.text != nil)
                [labelValues setObject:element.text forKey:@"teValue.text1"];
               else
                   [labelValues setObject:@"N/A" forKey:@"teValue.text1"];
                //teValue.text = element.text;
           }
           else if (count ==5){
               if (element.text != nil)
                [labelValues setObject:element.text forKey:@"beValue.text1"];
               else
                   [labelValues setObject:@"N/A" forKey:@"beValue.text1"];
                //beValue.text = element.text;
           }
           else if (count ==6){
               if (element.text != nil)
               [labelValues setObject:element.text forKey:@"nedValue.text1"];
               else
                   [labelValues setObject:@"N/A" forKey:@"nedValue.text1"];
                //nedValue.text = element.text;
           }
            else if (count ==7){
                if ([element.text isEqualToString:@"N/A"]){
                    [labelValues setValue:element.text forKey:@"drValue.text1"];
                    //drValue.text = element.text;
                } else {
                for (TFHppleElement *child in element.children){
                    if (([child.tagName isEqualToString: @"span"]) && count2 ==0)
                    {
                        if (child.text != nil){
                            [drValue1 appendString:child.text];
                            count2++;
                        } else {
                            if (([child.firstChild.tagName isEqualToString: @"span"]) && count2 ==0)
                            {
                                if (child.firstChild.text != nil){
                                    //[drValue1 appendString:@" - "];
                                    [drValue1 appendString:child.firstChild.text];
                                    count2++;
                                }
                                
                            }
                        }
                    }
                    else if (([child.tagName isEqualToString: @"span"]) && count2 ==1){
                        
                        
                        if (child.text != nil){
                            [drValue1 appendString:@" - "];
                            [drValue1 appendString:child.text];
                            count2++;
                        } else {
                            if (([child.firstChild.tagName isEqualToString: @"span"]) && count2 ==1)
                            {
                                if (child.firstChild.text != nil){
                                    [drValue1 appendString:@" - "];
                                    [drValue1 appendString:child.firstChild.text];
                                    count2++;
                                }
                                
                            }
                        }
                        
                    }
                }
                    
                [labelValues setObject:drValue1 forKey:@"drValue.text1"];
                //drValue.text = drValue1;
                count2=0;
                }
            }
            else if (count == 8){
                if ([element.text isEqualToString:@"N/A"]){
                    [labelValues setObject:element.text forKey:@"rValue.text1"];
                    //rValue.text = element.text;
                } else {
                    for (TFHppleElement *child in element.children){
                        if (([child.tagName isEqualToString: @"span"]) && count2 ==0)
                        {
                            if (child.text != nil){
                                [rValue1 appendString:child.text];
                                count2++;
                            } else {
                                if (([child.firstChild.tagName isEqualToString: @"span"]) && count2 ==0)
                                {
                                    if (child.firstChild.text != nil){
                                        [rValue1 appendString:child.firstChild.text];
                                        count2++;
                                    }
                                    
                                }
                            }
                        }
                        else if (([child.tagName isEqualToString: @"span"]) && count2 ==1){
                            
                            
                            if (child.text != nil){
                                [rValue1 appendString:@" - "];
                                [rValue1 appendString:child.text];
                                count2++;
                            } else {
                                if (([child.firstChild.tagName isEqualToString: @"span"]) && count2 ==1)
                                {
                                    if (child.firstChild.text != nil){
                                        [rValue1 appendString:@" - "];
                                        [rValue1 appendString:child.firstChild.text];
                                        count2++;
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                    [labelValues setObject:rValue1 forKey:@"rValue.text1"];
                    //rValue.text = rValue1;
                    count2=0;
                }
            }
                //rValue.text = element.text;
            else if (count == 9){
                if ([element.text isEqualToString:@"N/A"]){
                    [labelValues setObject:element.text forKey:@"vValue.text1"];
                    //vValue.text = element.text;
                } else{
                    if (element.firstChild.text != nil)
                    [labelValues setObject:element.firstChild.text forKey:@"vValue.text1"];
                    else
                        [labelValues setObject:@"N/A" forKey:@"vValue.text1"];
                    //vValue.text = element.firstChild.text;
                }
            }
            else if (count == 10){
                if (element.text != nil)
                [labelValues setObject:element.text forKey:@"avValue.text1"];
                else
                    [labelValues setObject:@"N/A" forKey:@"avValue.text1"];
                //avValue.text = element.text;
            }
            else if (count ==11){
                if ([element.text isEqualToString:@"N/A"]){
                    [labelValues setObject:element.text forKey:@"mcValue.text1"];
                    //mcValue.text = element.text;
                } else{
                    if (element.firstChild.text != nil)
                    [labelValues setObject:element.firstChild.text forKey:@"mcValue.text1"];
                    else
                        [labelValues setObject:@"N/A" forKey:@"mcValue.text1"];
                    //mcValue.text = element.firstChild.text;
                }
            }
            else if (count == 12){
                if (element.text != nil)
                [labelValues setObject:element.text forKey:@"peValue.text1"];
                else
                    [labelValues setObject:@"N/A" forKey:@"peValue.text1"];
                //peValue.text = element.text;
            }
            else if (count ==13){
                if (element.text != nil)
                [labelValues setObject:element.text forKey:@"epsValue.text1"];
                else
                    [labelValues setObject:@"N/A" forKey:@"epsValue.text1"];
                //epsValue.text = element.text;
            }
            else if (count ==14){
                if (element.text != nil)
                    [labelValues setObject:element.text forKey:@"dyValue.text1"];
                else
                    [labelValues setObject:@"N/A" forKey:@"dyValue.text1"];
                //dyValue.text = element.text;
            }
            count++;
            //NSLog(@"%@", quotesNodes[0]);
            //NSLog(@"%@", element.firstChild.firstChild.text);
                
        }
            
        
        //NSLog(@"Operation complete");
        

}



- (void) updateInfo
{
    //[self createLabels];
    [self readYahooFinance];
    
    
    //NSLog(@"updateInfo");
    //[self performSelectorOnMainThread:@selector(updateLabelsOnScreen) withObject:nil waitUntilDone:YES];
    //[self reloadInputViews];
    //[self.view reloadInputViews];
}
- (void) updateLabelsOnScreen
{
    name.text = [labelValues objectForKey:@"name.text1"];
    //NSLog(@"%@",name.text);
    symbol.text = [labelValues objectForKey:@"symbol.text1"];
    icon.image = iconImgTemp;
    percent.textColor = poiColor;
    points.textColor = percColor;
    chart.image = chartImgTemp;
    [price setText: [labelValues objectForKey:@"price.text1"]];
    //NSLog(@"%@",price.text);
    [price setNeedsDisplay];
    [points setText: [labelValues objectForKey:@"points.text1"]];
    //NSLog(@"%@",points.text);
    [points setNeedsDisplay];
    [percent setText: [labelValues objectForKey:@"percent.text1"]];
    //NSLog(@"%@",percent.text);
    [percent setNeedsDisplay];
    [lastTrade setText: [labelValues objectForKey:@"lasttrade.text1"]];
    //NSLog(@"%@",lastTrade.text);
    pcValue.text = [labelValues objectForKey:@"pcValue.text1"];
    oValue.text = [labelValues objectForKey:@"oValue.text1"];
    bValue.text = [labelValues objectForKey:@"bValue.text1"];
    aValue.text = [labelValues objectForKey:@"aValue.text1"];
    teValue.text = [labelValues objectForKey:@"teValue.text1"];
    beValue.text = [labelValues objectForKey:@"beValue.text1"];
    nedValue.text = [labelValues objectForKey:@"nedValue.text1"];
    drValue.text = [labelValues objectForKey:@"drValue.text1"];
    rValue.text = [labelValues objectForKey:@"rValue.text1"];
    vValue.text = [labelValues objectForKey:@"vValue.text1"];
    avValue.text = [labelValues objectForKey:@"avValue.text1"];
    mcValue.text = [labelValues objectForKey:@"mcValue.text1"];
    peValue.text = [labelValues objectForKey:@"peValue.text1"];
    epsValue.text = [labelValues objectForKey:@"epsValue.text1"];
    dyValue.text = [labelValues objectForKey:@"dyValue.text1"];
}

-(void) viewWillDisappear:(BOOL)animated
{
}

@end

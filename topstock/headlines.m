//
//  headlines.m
//  topstock
//
//  Created by Farah Sadoon on 13-12-07.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import "headlines.h"

@implementation headlines
{
    UIBarButtonItem *back;
    int count;
    //int webViewLoads_;
    //NSString *htmlString;
}
@synthesize news;
@synthesize webNav;
@synthesize loaded;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)goBack
{
    [news goBack];
}
-(void) loadPage: (NSString *)url{
    news = [[UIWebView alloc] initWithFrame:self.view.frame];
    //CGRect frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width , 44);
    news.delegate = self;
    //webNav = [[UIToolbar alloc] init];
        NSString *link = url;
    //count = 0;
    
    
    NSLog(@"%@", link);
    //NSString *link = @"http://m.tsn.ca";
    [news loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
    [news scalesPageToFit];
    //news.backgroundColor = [UIColor clearColor];
    //news.opaque = false;
    back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBack)];
    NSMutableArray *toolbarButtons = [self.toolbarItems mutableCopy];
    [back setEnabled:false];
    [toolbarButtons addObject:back];
    [self.webNav setItems:[NSArray arrayWithObject:back]];
    //[self.webNav bringSubviewToFront:back];
    //[self.back setEnabled:false];
    //[h1.news setDelegate:self];
    //NSArray *buttonsArray = [NSArray arrayWithObjects:back, nil];
    //[buttonsArray addObject:back];
    //[self.webNav setItems:buttonsArray animated:NO];
    
    [self.view addSubview: self.news];
    //[self.view addSubview: self.webNav];
    //[self.view insertSubview:self.news belowSubview:self.webNav];
    

    //[self.news.scrollView addSubview:self.webNav];
    
    [self.view bringSubviewToFront:self.view.subviews[1]];
    //[self.news insertSubview:self.news belowSubview:self.webNav];
    //[self.view insertSubview:self.news belowSubview:self.webNav];

}


- (void) webViewDidFinishLoad:(UIWebView *) webView
{
    
     loaded = YES;

    //[newsSub scalesPageToFit];
    
    [back setEnabled:[webView canGoBack]];
    //NSLog(@"canGoBack: %i",[webView canGoBack]);
    //NSLog(@"self.back is Enabled: %i",self.back.isEnabled);
    //[webView reload];
    //NSLog(@"calls WebviewDidFinishLoad");
}

- (void) webView:(UIWebView *) webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ERROR LOADING WEBPAGE: %@", error);
    loaded = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

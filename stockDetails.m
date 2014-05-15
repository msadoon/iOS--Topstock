//
//  stockDetails.m
//  topstock
//
//  Created by Farah Sadoon on 13-11-28.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import "stockDetails.h"
#import "stockViewA.h"
#import "stockViewB.h"

@interface stockDetails ()

@end

@implementation stockDetails
{
@private

    BOOL pageControlBeingUsed;
}

@synthesize scrollView;
@synthesize pageControl;
@synthesize viewArray;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *) scrollView {
    pageControlBeingUsed = NO;
}

- (void) scrollViewDidEndDecelerating: (UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (IBAction)changePage {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    for (int i = 0; i < colors.count; i++){
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width *i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        //NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"stockViewA" owner:self options:nil];
        //if (!self.viewA) {
        //    self.viewA = [[stockViewA alloc] initWithNibName:@"stockViewA" bundle:nil];
        //}
        //self.viewA = [[stockViewA alloc] initWithFrame:frame];
        //subview = [nibContents objectAtIndex:0];
        //self.viewA.backgroundColor = [colors objectAtIndex:i];
        //[self.scrollView addSubview:self.viewA];
        //[subview release];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width *colors.count, self.scrollView.frame.size.height);
    
    pageControlBeingUsed = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *) sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) +1;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

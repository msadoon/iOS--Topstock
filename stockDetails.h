//
//  stockDetails.h
//  topstock
//
//  Created by Farah Sadoon on 13-11-28.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class stockViewA;

@interface stockDetails : UIViewController {
    UIScrollView * scrollView;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *viewArray;
- (IBAction)changePage;
@property (nonatomic, retain) stockViewA *viewA;
@end

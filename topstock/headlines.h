//
//  headlines.h
//  topstock
//
//  Created by Farah Sadoon on 13-12-07.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headlines : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *news;
@property (strong, nonatomic) IBOutlet UIToolbar *webNav;
@property BOOL loaded;
-(void) loadPage: (NSString *)url;
@end

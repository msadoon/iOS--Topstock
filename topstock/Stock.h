//
//  Tutorial.h
//  topstock
//
//  Created by Farah Sadoon on 13-11-16.
//  Copyright (c) 2013 msadoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject

@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ltrade;
@property (nonatomic, copy) NSString *pct;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *volume;
@property (nonatomic, copy) NSString *img_url;

@end

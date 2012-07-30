//
//  RssData.h
//
//  Created by Neeku Shamekhi on 1/4/12.
//  Copyright 2012 __TGBS__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssData : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *fullDescription;
@property (nonatomic) NSString *shortTitle;
@property (nonatomic) NSString *shortDescription;
@property (nonatomic) NSString *linkUrl;
@property (nonatomic) NSString *guidUrl;
@property (nonatomic) NSString *pubDate;
@property (nonatomic) NSString *mediaUrl;
@property (nonatomic) UIImage  *image;
@property (nonatomic) NSString *author;

@end

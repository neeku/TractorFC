//
//  RssParser.h
//  
//
//  Created by Neeku Shamekhi on 1/4/12.
//  Copyright 2012 __TGBS__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RssData;
@protocol RssParserDelegate;

@interface RssParser : NSObject <NSXMLParserDelegate> 
{
    RssData                 * _currentItem;
    NSMutableString         * _currentItemValue;
    NSMutableArray          * _rssItems;
    id<RssParserDelegate>   delegate;
    NSOperationQueue        *_retrieverQueue;
    NSUInteger              parsingNewsWithNumber;
    NSOperationQueue        *queue;
   // NSTimer                 *timer;
    NSString                *imageURL;

}

@property (strong, nonatomic)   RssData             * currentItem;
@property (nonatomic)   NSMutableString     * currentItemValue;
@property (readonly)            NSMutableArray      * rssItems;

@property (nonatomic)   id<RssParserDelegate> delegate;
@property (nonatomic)   NSOperationQueue    *retrieverQueue;
@property (nonatomic)   NSString            *selectedCategory;
@property (nonatomic)   NSOperationQueue    *queue;
@property (nonatomic)   NSString            *imageURL;

@property (nonatomic)   NSString             *parseFinished;
- (void)startProcess;

@end

@protocol RssParserDelegate <NSObject>

- (void) imageProcessCompleted;
- (void) processCompleted;
- (void) processHasErrors;

@end

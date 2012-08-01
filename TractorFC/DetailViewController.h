//
//  DetailViewController.h
//  
//
//  Created by  on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NATitleBar.h"
#import "RssParser.h"
@class RssParser;
@class RssData;
@interface DetailViewController : UIViewController <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic)                       RssData         *rssData;
@property (nonatomic)                       NSString        *selectedItem;
@property (strong, nonatomic)               RssParser       *rssParser;
@property (strong, nonatomic)               UIWebView       *webView;


@end

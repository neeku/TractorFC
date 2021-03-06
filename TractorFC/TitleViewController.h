//
//  TitleViewController.h
//  
//
//  Created by  on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssParser.h"
//#import "NATitleBar.h"
#import "DetailViewController.h"

@interface TitleViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,RssParserDelegate, UINavigationControllerDelegate>
{
    NSMutableDictionary     *imagesCache;
}
@property (nonatomic)           RssParser               *rssParser;
@property (nonatomic)           NSString                *selectedCategory;
@property (nonatomic)           NSString                *parseFinished;

//_nshamekhi_ To support earlier iOS versions, unsafe_unretained must be used instead of weak.
@property (unsafe_unretained, nonatomic)IBOutlet     UITableView             *titleTableView;
@property (nonatomic)                                UIActivityIndicatorView *activityIndicator;
//@property (strong, nonatomic)           IBOutlet     NATitleBar              *titleView;

- (void)loadImage: (NSArray *) argArray;
- (void)displayImage: (NSArray *) argArray;

- (void)back;
- (void)home;

@end

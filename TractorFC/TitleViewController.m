//
//  TitleViewController.m
//  
//
//  Created by  on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TitleViewController.h"
#import "RssParser.h"
#import "RssData.h"
#import "Constant.h"
#import "ProAlertView.h"
#import "FarsiNumerals.h"
#import "AppDelegate.h"

@interface TitleViewController ()
    
@end

#define TITLE_LABEL_TAG   1
#define SUMMARY_LABEL_TAG 2
//#define DATE_LABEL_TAG    3
#define PHOTO_TAG         4
#define IMAGE_TAG         5

@implementation TitleViewController

@synthesize titleTableView;
@synthesize selectedCategory;
@synthesize rssParser;
@synthesize activityIndicator;
@synthesize titleView;
@synthesize parseFinished;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"News", @"News");
        self.tabBarItem.image = [UIImage imageNamed:@"news"];
    }
    return self;
}

- (void)viewDidLoad
{

    NSLog(@"parse:,%@", parseFinished);
    [super viewDidLoad];
    titleView = [[NATitleBar alloc]initWithFrame:HEADER_FRAME];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    [titleView.back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [titleView.home addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    
    //_nshamekhi_ Gets the selected category name from the CategoryPlist.plist file and sets it to the title for the view.
    NSString *file = [[NSBundle  mainBundle] pathForResource:@"CategoryPlist"
                                                      ofType:@"plist"];
    NSDictionary *item = [[NSDictionary alloc]initWithContentsOfFile:file];
    NSArray *array = [item objectForKey:@"Root"];
    NSString *categoryName = [NSString stringWithString:
                  [[array objectAtIndex:[selectedCategory intValue]]objectForKey:@"Name"]];
    globalCategoryName = [categoryName copy];
    titleView.label.text = categoryName;
    
    // Do any additional setup after loading the view from its nib.
    rssParser = [[RssParser alloc] init];
    [[self rssParser] setSelectedCategory:[self selectedCategory]];
    [[self rssParser] setDelegate:self];
    [[self rssParser] startProcess];
    
    
}

- (void)viewDidUnload
{
    
    [self setTitleTableView:nil];
    [super viewDidUnload];
    imagesCache = [[NSMutableDictionary alloc] init];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    [self shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    [super viewWillAppear:YES];
    
    //_nshamekhi_ Removes the current selection in the table view after navigating back to the view.
    NSIndexPath *tableSelection = [self.titleTableView indexPathForSelectedRow];
    [self.titleTableView deselectRowAtIndexPath:tableSelection animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    
    //NSLog(@"frame=%f",self.view.frame.size.width);
    float width;

    titleView.frame = CGRectMake(titleView.frame.origin.x,
                                 titleView.frame.origin.y,
                                 width,
                                 titleView.frame.size.height);
    NSLog(@"table view y:%f", titleView.frame.origin.y);
    
    
    return YES;
}

- (void)back {
   [self.navigationController popViewControllerAnimated:YES];
}
- (void)home {
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"home Pressed");
}

#pragma Table Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = [[[self rssParser] rssItems] count];
    NSLog(@"count1=%i", rowCount);
   
     

        return rowCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"rssItemCell"];
    
    UILabel *titleLabel;
    UILabel *summaryLabel;
    //UILabel *dateLabel;
    //UIImageView *bgIMG;
    UIImageView *photo;
    UIImageView *separator;

    

     if(cell1 == nil)
    {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:@"rssItemCell"];
                
        cell1.accessoryType = UITableViewCellAccessoryNone;
//        
//        bgIMG = [[UIImageView alloc]initWithFrame:CGRectMake(9, 0, 309, 40)];
//        bgIMG.tag = IMAGE_TAG;
//        bgIMG.image = [UIImage imageNamed:@"titlebar"];
//        bgIMG.autoresizingMask = UIViewAutoresizingFlexibleWidth
//        | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin;
//        [cell1.contentView addSubview:bgIMG];
        
        titleLabel = [[UILabel alloc] initWithFrame:TITLE_LABEL_FRAME];
        titleLabel.tag = TITLE_LABEL_TAG;
        titleLabel.font = [UIFont TITLE_LABEL_FONT];
        titleLabel.textAlignment = UITextAlignmentRight;
        titleLabel.textColor = [UIColor TITLE_LABEL_TEXT_COLOR];
        titleLabel.backgroundColor = [UIColor TITLE_LABEL_BG_COLOR];
        
        
        titleLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        [cell1.contentView addSubview:titleLabel];
        
                       
        summaryLabel = [[UILabel alloc] initWithFrame:SUMMARY_LABEL_FRAME] ;
        summaryLabel.tag = SUMMARY_LABEL_TAG;
        summaryLabel.numberOfLines = 0;
        summaryLabel.font = [UIFont SUMMARY_LABEL_FONT];
        summaryLabel.textAlignment = UITextAlignmentRight;
        summaryLabel.textColor = [UIColor SUMMARY_LABEL_TEXT_COLOR];
        summaryLabel.backgroundColor = [UIColor SUMMARY_LABEL_BG_COLOR];
        summaryLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth ;
        [cell1.contentView addSubview:summaryLabel];
        
        photo = [[UIImageView alloc] initWithFrame:PHOTO_FRAME] ;
        photo.tag = PHOTO_TAG;
        photo.backgroundColor = [UIColor PHOTO_BG_COLOR];
        photo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [cell1.contentView addSubview:photo];
        
        separator = [[UIImageView alloc]initWithFrame:SEPARATOR_FRAME];
        separator.tag = IMAGE_TAG;
        separator.image = [UIImage imageNamed:@"divider"];
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //| UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin;
        [cell1.contentView addSubview:separator];
    }
    else 
    {
        titleLabel = (UILabel *) [cell1.contentView viewWithTag:TITLE_LABEL_TAG];
        summaryLabel = (UILabel *) [cell1.contentView viewWithTag:SUMMARY_LABEL_TAG];
        photo = (UIImageView *) [cell1.contentView viewWithTag:PHOTO_TAG];
        separator = (UIImageView *) [cell1.contentView viewWithTag:IMAGE_TAG];

        //bgIMG = (UIImageView *) [cell1.contentView viewWithTag:IMAGE_TAG];
        
    }
    


    RssData *data = [[[self rssParser] rssItems] objectAtIndex:indexPath.row];
    
    NSString *blank;
    blank = @"    ";
    titleLabel.text = [blank stringByAppendingString:[FarsiNumerals convertNumeralsToFarsi:[data shortTitle]]];
    //Label.text = [data pubDate];
    summaryLabel.text = [data shortDescription];
    
    if ([data image] != nil) {
        [photo setImage:[data image]];
    }
    else {
        [photo setImage:[UIImage imageNamed:@"Unknown"]];
    }
    
    //_nshamekhi_ Changes the selected cell color from default blue color to gray.
    cell1.selectionStyle = UITableViewCellSelectionStyleGray;
       
     
        
    return cell1;
    }
    



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailView1 *detailViewController = [[DetailView1 alloc] initWithNibName:@"" bundle:nil];
    [detailViewController setRssData:[[[self rssParser] rssItems] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES]; 
	NSLog(@"dv loading");
}

- (void)loadImage:(NSArray *)argArray {
    
    UIImageView* photo;
    RssData* data;
    NSString* indexOfRow;
    
    data=(RssData *)[argArray objectAtIndex:0];
    photo=(UIImageView *)[argArray objectAtIndex:1];
    indexOfRow=[argArray objectAtIndex:2];
    
    
    UIImage* image = nil;
    NSData* imageData;
    
    if([imagesCache objectForKey:indexOfRow]==nil)
    {
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[data mediaUrl]]];
        image = [UIImage  imageWithData:imageData];
        
        [imagesCache setObject:image forKey:indexOfRow];
        
   }
    else
    {
        image = (UIImage*)[imagesCache valueForKey:indexOfRow];  
       
    }
    
}

- (void)displayImage:(NSArray *)argArray {

    [(UIImageView *)[argArray objectAtIndex:0] setImage:(UIImage *)[argArray objectAtIndex:1]];
}

#pragma -
#pragma Rss Delegate

- (void)imageProcessCompleted
{
    //[self displayImage];
    //[[] reloadData];
    //RssData *data = [[[self rssParser] rssItems] objectAtIndex:0];
    //UIImageView *photo;
    //photo = (UIImageView *) [[ [self titleTableView] cellForRowAtIndexPath:0].contentView viewWithTag:PHOTO_TAG];
    //[photo setImage:[data image]];
    //= [ [ [self titleTableView] cellForRowAtIndexPath:0] subviews:0];
    
    
    //
    if  ([rssParser imageURL])
    {
        [[self titleTableView] reloadData];
        //  [(id)[rssParser delegate] performSelectorOnMainThread:@selector(processCompleted)
        //                                     withObject:nil
        //                                  waitUntilDone:NO];
    }
    
    NSLog(@"imageProcessComplete");
    
}



- (void)processCompleted
{
    [[self titleTableView] reloadData];
    [activityIndicator stopAnimating];
    NSInteger rowCount = [[[self rssParser] rssItems] count];

    if (rowCount!=0) {
        
        titleTableView.delegate = self;
        titleTableView.dataSource = self;
        titleTableView.contentSize = TABLEVIEW_CONTENT_SIZE;
         }
                  else if ((rowCount==0) &&([UIApplication sharedApplication].networkActivityIndicatorVisible == NO ) ){
                      UILabel *noContentWarning = [[UILabel alloc] initWithFrame:NO_CONTENT_WARNING_FRAME];
             noContentWarning.text = NO_CONTENT_WARNING_MESSAGE;
             noContentWarning.font = [UIFont NO_CONTENT_WARNING_FONT];
             noContentWarning.textAlignment = UITextAlignmentCenter;
             noContentWarning.backgroundColor = [UIColor NO_CONTENT_WARNING_BG_COLOR];
             noContentWarning.autoresizingMask = UIViewAutoresizingFlexibleWidth;
             [self.view addSubview:noContentWarning];
             noContentWarning.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3);
         }

}


- (void)processHasErrors
{
    //Due to internet connection or server error.
    ProAlertView *alert = [[ProAlertView alloc] initWithTitle:NO_CONNECTION_ALERT_TITLE message: NO_CONNECTION_ALERT_MESSAGE delegate:self cancelButtonTitle:NO_CONNECTION_ALERT_VIEW_DISMISS_BUTTON otherButtonTitles:nil];

    [alert setBackgroundColor:[UIColor NO_CONNECTION_ALERT_VIEW_COLOR] withStrokeColor: 
     [UIColor NO_CONNECTION_ALERT_VIEW_STROKE_COLOR]];
    
    
    [alert show];
    [activityIndicator stopAnimating];
}
@end

//
//  DetailView.m
//  
//
//  Created by  on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailView.h"
#import "RssData.h"
#import "RssParser.h"
#import "AppDelegate.h"
#import "UIWebView+Clean.h"

@class RssParser;

@interface DetailView ()

@end

@implementation DetailView

//@synthesize header;
@synthesize webView;
@synthesize selectedItem;
@synthesize rssParser;
@synthesize rssData;
@synthesize footer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectedItem = [[NSString alloc]init];
    }
    return self;
}





- (void)loadView
{

    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    NSString *path = [[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"htmlPattern" ofType:@"html"]];
    
    /*
     /Users/nshamekhi/Library/Application Support/iPhone Simulator/5.0/Applications/FE14D377-4835-4458-A87F-D78FD49775B6/Javan.app */
    
     
//     NSString *paths = [[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"table-web-bgP" ofType:@"png"]];
    //NSLog(@"path=%@",paths);
    NSError *error;
    NSString *pattern = [[NSString alloc]initWithContentsOfFile:path 
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    NSLog(@"pattern=%@",pattern);
    
  
    NSString *backgroundPath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"png"];
    NSURL    *backgroundURL  = [NSURL fileURLWithPath:backgroundPath];
    NSString *htmlPage;
    NSString *fullDescription = [rssData fullDescription];
    //NSLog(@"shortened text:%@", shortenedFullDescription);
    
    htmlPage = [[NSString  alloc]initWithFormat:pattern,
                backgroundURL,
                [rssData mediaUrl],
                [rssData title],
                fullDescription ]; 
    webView = [[UIWebView alloc] initWithFrame:WEBVIEW_FRAME];
    [webView loadHTMLString:htmlPage baseURL:[NSURL URLWithString:path]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pattern]]];
    webView.userInteractionEnabled  = YES;
    
     
    //if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= __IPHONE_5_0  ) {
     //       webView.scrollView.contentSize=CGSizeMake(1000, 1500); //NOT COMPATIBLE WITH OLDER iOS VERSIONS.
     //   webView.scrollView.maximumZoomScale = 6;              //NOT COMPATIBLE WITH OLDER iOS VERSIONS.
        
  //  }

    
    webView.scalesPageToFit = YES;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth 
    | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
    |UIViewAutoresizingFlexibleBottomMargin ;
    [webView setOpaque:NO];

    //webView.scrollView.minimumZoomScale = 0.5;            //NOT COMPATIBLE WITH OLDER iOS VERSIONS.
    
    webView.backgroundColor = [UIColor whiteColor];
    
    webView.delegate = self;
    self.view =webView;
    
    if (!globalCategoryName)
    {
        globalCategoryName = [[NSString alloc] init];
    }
    
    
//    header = [[NATitleBar alloc]initWithFrame:HEADER_FRAME];
//    header.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:header];
//    header.label.text = globalCategoryName;
//    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//
//    
//    [header.back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [header.home addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];

    UIView *titleView = [[UIView alloc]initWithFrame:TITLE_Frame];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin ;
    
//    UIImageView *bgIMG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 309, 30)];
//    bgIMG.image = [UIImage imageNamed:@"titlebar"];
//    bgIMG.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
//    | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
//    |UIViewAutoresizingFlexibleBottomMargin ;
//    [titleView addSubview:bgIMG];
    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, -5, 210, 30)];
//                                                                    
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textAlignment = UITextAlignmentRight;
//    titleLabel.textColor = [UIColor greenColor];
//    titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    titleLabel.text = [rssData title];
//    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
//    | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
//    |UIViewAutoresizingFlexibleBottomMargin ;
//    [titleView addSubview:titleLabel];
    
//    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -5, 90, 30)];
//    dateLabel.backgroundColor = [UIColor clearColor];
//    dateLabel.textAlignment = UITextAlignmentCenter;
//    dateLabel.textColor = [UIColor whiteColor];
//    dateLabel.font = [UIFont boldSystemFontOfSize:13];
//    dateLabel.text = [rssData pubDate];
//    dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
//    | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
//    |UIViewAutoresizingFlexibleBottomMargin ;
//    [titleView addSubview:dateLabel];
//    
//    [self.view addSubview:titleView];
    
    
    footer = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                     self.view.frame.size.height-Y_ORIGIN_FOOTER,
                                                     self.view.frame.size.width,
                                                     Y_ORIGIN_FOOTER)];
    footer.backgroundColor = [UIColor darkGrayColor];
    UIImageView *footerIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"footer"]];
    footerIMG.frame = CGRectMake(0, 0, footer.frame.size.width, footer.frame.size.height);
    footerIMG.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    [footer addSubview:footerIMG];
    [self.view addSubview:footer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [self.webView cleanForDealloc];
    self.webView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    header.frame = CGRectMake(header.frame.origin.x,
//                                 header.frame.origin.y,
//                                 self.view.frame.size.width,
//                                 header.frame.size.height);
    
    webView.frame = CGRectMake(webView.frame.origin.x,
                                 webView.frame.origin.y,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height - webView.frame.origin.y);
    NSLog(@"height=%f",webView.frame.size.height);

    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        footer.frame = CGRectMake(0, 280, L_WIDTH, Y_ORIGIN_FOOTER);
    }
    else {
        footer.frame = CGRectMake(0, 440, P_WIDTH, Y_ORIGIN_FOOTER);
    }
    
    return YES;
}

- (void)sendEvent:(UIEvent *)event {
    //NSLog(@"tap detect");
   // NSArray *allTouches = [[event allTouches] allObjects];
    UITouch *touch = [[event allTouches] anyObject];
    UIView *touchView = [touch view];
    
    if (touchView && [touchView isDescendantOfView:webView]) {
        //
        // touchesBegan
        //
        if(touch.tapCount==2){
            //
            // doubletap
            webView.contentScaleFactor = 1.0;          
            //
        }
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale { // scale between minimum and maximum. called after any 'bounce' animations
    //view.
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)home {
    [self.navigationController popToRootViewControllerAnimated:YES];
    //NSLog(@"gohome Pressed");
}

@end

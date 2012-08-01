//
//  DetailViewController.m
//  
//
//  Created by  on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RssData.h"
#import "RssParser.h"
#import "AppDelegate.h"
#import "UIWebView+Clean.h"

@class RssParser;

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize webView;
@synthesize selectedItem;
@synthesize rssParser;
@synthesize rssData;


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
    
    NSError *error;
    NSString *pattern = [[NSString alloc]initWithContentsOfFile:path 
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    NSLog(@"pattern=%@",pattern);
    
  
//    NSString *backgroundPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
//    NSURL    *backgroundURL  = [NSURL fileURLWithPath:backgroundPath];
    NSString *htmlPage;
    NSString *fullDescription = [rssData fullDescription];
    
    htmlPage = [[NSString  alloc]initWithFormat:pattern,
           //     backgroundURL,
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
    

//    UIImageView *bgIMG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 309, 30)];
//    bgIMG.image = [UIImage imageNamed:@"titlebar"];
//    bgIMG.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
//    | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
//    |UIViewAutoresizingFlexibleBottomMargin ;
//    [titleView addSubview:bgIMG];
    
    
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
    webView.frame = CGRectMake(webView.frame.origin.x,
                                 webView.frame.origin.y,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height - webView.frame.origin.y);

    

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


@end

//
//  LeagueTableViewController.m
//  TractorFC
//
//  Created by neeku shamekhi on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LeagueTableViewController.h"
#import "FarsiNumberals.h"

@interface LeagueTableViewController ()

@end

@implementation LeagueTableViewController

@synthesize leagueTableWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"LeagueTable", @"LeagueTable");
        self.tabBarItem.image = [UIImage imageNamed:@"table"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSURL *url = [[NSURL alloc] initWithString:@"http://www.iranskin.com/league/view.php?league=iran&fc=333333&tfc=FFFFFF&btc=B00000&bic=686868&bg1=DBDBDB&bg2=FFFFFF&gp=1&won=1&drawn=1&lost=1&gs=none&ga=none&gr=none"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [leagueTableWebView loadRequest:request];
    leagueTableWebView.userInteractionEnabled = NO;
    [self.view addSubview:leagueTableWebView];
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Loading and injecting your JavaScript code into the webView, so you can actually use it
    // in the context of the web page that was loaded...
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

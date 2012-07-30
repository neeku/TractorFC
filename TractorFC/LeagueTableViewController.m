//
//  LeagueTableViewController.m
//  TractorFC
//
//  Created by neeku shamekhi on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LeagueTableViewController.h"

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
    [leagueTableWebView setDelegate:self];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Loading and injecting your JavaScript code into the webView, so you can actually use it
    // in the context of the web page that was loaded...
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LeagueTable" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    
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

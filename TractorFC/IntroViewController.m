//
//  IntroViewController.m
//  TractorFC
//
//  Created by neeku shamekhi on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

@synthesize introTextView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Intro", @"Intro");
        self.tabBarItem.image = [UIImage imageNamed:@"Intro"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *introTextPath = [[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"Intro" ofType:@"txt"]];
    NSString *introText = [NSString stringWithContentsOfFile:introTextPath encoding:NSUTF8StringEncoding error:nil];
    introTextView.text = introText;
    [self.view addSubview:introTextView];
    
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

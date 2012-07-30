//
//  ModalViewController.m
//  
//
//  Created by neeku shamekhi on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModalViewController.h"
#import "TitleViewController.h"
#import "NATitleBar.h"
#import "Constant.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

@synthesize appName, copyright;
//@synthesize header;
//@synthesize titleView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    titleView = [[NATitleBar alloc]initWithFrame:HEADER_FRAME];
//    titleView.backgroundColor = [UIColor whiteColor];
//    titleView.label.text = @"درباره برنامه";
//    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self.view addSubview:titleView];
    
    
    
//    [titleView.back addTarget:self action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
//    titleView.home.hidden = YES; 

    appName.editable = YES;
    self.appName.userInteractionEnabled = NO;
    self.view.backgroundColor = [UIColor clearColor];
	self.appName.text = ABOUT_APP_TEXT;
    appName.editable=NO;
    appName.font = [UIFont boldSystemFontOfSize:15];
    //self.appName.userInteractionEnabled = YES;

    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSString *name= [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    
	self.copyright.text = [NSString stringWithFormat:@"%@ V. %@ \n ©2012",name,version];
    copyright.font = [UIFont boldSystemFontOfSize:12];
    copyright.userInteractionEnabled = NO;
    

    
    //NSLog(@"version=%@",version);
}

- (IBAction)dismissAction:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
    [self.parentViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];

}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    return YES;
}

//- (void)back {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)home {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    NSLog(@"gohome Pressed");
//]}

@end

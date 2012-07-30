//
//  PhotosViewController.m
//  sampletab
//
//  Created by neeku shamekhi on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

@synthesize image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Photos", @"Photos");
        self.tabBarItem.image = [UIImage imageNamed:@"landscape"];
    }
    return self;
}
				
-(IBAction)buttonTapped:(UIButton*)button
{
    switch (button.tag) 
	{
		case 1:
			[image setImage:[UIImage imageNamed:@"1.jpeg"]];			
			break;
		case 2:
            [image setImage:[UIImage imageNamed:@"2.jpeg"]];
            break;
        case 3:
            [image setImage:[UIImage imageNamed:@"3.jpeg"]];
            break;
		case 4:
            [image setImage:[UIImage imageNamed:@"4.jpeg"]];
            break;
		case 5:
            [image setImage:[UIImage imageNamed:@"5.jpeg"]];
            break;
		case 6:
            [image setImage:[UIImage imageNamed:@"6.jpeg"]];
            break;
		case 7:
            [image setImage:[UIImage imageNamed:@"7.jpeg"]];
            break;

    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	//[self.view addSubview:image];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

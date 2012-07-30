//
//  PhotosViewController.h
//  sampletab
//
//  Created by neeku shamekhi on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewController : UIViewController
{
    IBOutlet UIImageView *image;
}
@property (nonatomic, retain) IBOutlet UIImageView *image;

-(IBAction)buttonTapped:(UIButton*)button;

@end

//
//  ModalViewController.h
//  
//
//  Created by neeku shamekhi on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NATitleBar.h"

@interface ModalViewController : UIViewController
{
    UITextView *appName, *copyright, *detail;
        
}

@property (nonatomic, strong) IBOutlet  UITextView      *appName, *copyright;
//@property (nonatomic)                   UIView          *header;
//@property (nonatomic)                   NATitleBar      *titleView;


//- (IBAction)dismissAction:(id)sender;
//- (void)back;

@end

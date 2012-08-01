//
//  AppDelegate.h
//  TractorFC
//
//  Created by neeku shamekhi on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//NSString *globalCategoryName;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic)          UIWindow *window;

@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic)          UITabBarController     *tabBarController;

@end

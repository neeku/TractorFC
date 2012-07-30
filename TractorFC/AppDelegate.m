//
//  AppDelegate.m
//  TractorFC
//
//  Created by neeku shamekhi on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroViewController.h"
#import "TitleViewController.h"
#import "PhotosViewController.h"
#import "LeagueTableViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.window.rootViewController = navigationController;
    
    
    UIViewController *viewController0 = [[IntroViewController alloc] initWithNibName:@"IntroViewController" bundle:nil];
    UIViewController *viewController1 = [[TitleViewController alloc] initWithNibName:@"TitleViewController" bundle:nil];
    UIViewController *viewController2 = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController" bundle:nil];
    UIViewController *viewController3 = [[LeagueTableViewController alloc] initWithNibName:@"LeagueTableViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController0, viewController1, viewController2, viewController3,nil];
    self.window.rootViewController = self.tabBarController;
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. League should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}


@end

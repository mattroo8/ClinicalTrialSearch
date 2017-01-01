//
//  AppDelegate.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:[self setupMainView]
                                                    leftMenuViewController:[SideMenuViewController new]
                                                    rightMenuViewController:nil];
    self.window.rootViewController = container;
    container.panMode = MFSideMenuPanModeNone;
    [self.window makeKeyAndVisible];
    return YES;
}

-(UINavigationController *)setupMainView{
    SearchViewController *svc2 = [SearchViewController new];
    svc2.title = @"Disease Lookup";
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:svc2];
    navVC.view.backgroundColor = [UIColor whiteColor];
    navVC.navigationBar.barTintColor = [UIColor colorWithRed:0.433964f green:0.837138f blue:0.575706f alpha:1.0f];
    return navVC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

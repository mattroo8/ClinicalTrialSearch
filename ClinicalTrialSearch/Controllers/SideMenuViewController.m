//
//  SideMenuViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 30/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "SearchViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.433964f green:0.837138f blue:0.575706f alpha:1.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)diseaseButton:(id)sender
{
    MFSideMenuContainerViewController *controller = (MFSideMenuContainerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)controller.centerViewController;
    SearchViewController *svc = (SearchViewController *)nav.topViewController;
    [svc switchToDiseaseLookUp];
    [controller toggleLeftSideMenuCompletion:^{}];
}
- (IBAction)medTrialButton:(id)sender {
    MFSideMenuContainerViewController *controller = (MFSideMenuContainerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)controller.centerViewController;
    SearchViewController *svc = (SearchViewController *)nav.topViewController;
    [svc switchToTrialLookUp];
    [controller toggleLeftSideMenuCompletion:^{}];
}
- (IBAction)aboutButtonPressed:(id)sender {
    NSLog(@"Switch to about view");
}

@end

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
#import "AboutViewController.h"

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
    SearchViewController *svc = [SearchViewController new];
    if([nav.topViewController isKindOfClass:[SearchViewController class]]){
        svc = (SearchViewController *)nav.topViewController;
    }
    svc.inDiseaseSearch = NO;
    [svc switchToDiseaseLookUp];
    [nav setViewControllers:[NSArray arrayWithObject:svc] animated:NO];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"]
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(toggleLeftMenu)];
    
    nav.navigationBar.topItem.leftBarButtonItem = btn;
    [controller toggleLeftSideMenuCompletion:^{}];
}
- (IBAction)medTrialButton:(id)sender {
    MFSideMenuContainerViewController *controller = (MFSideMenuContainerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)controller.centerViewController;
    SearchViewController *svc = [SearchViewController new];
    if([nav.topViewController isKindOfClass:[SearchViewController class]]){
        svc = (SearchViewController *)nav.topViewController;
    }
    svc.inDiseaseSearch = YES;
    [svc switchToTrialLookUp];
    [nav setViewControllers:[NSArray arrayWithObject:svc] animated:NO];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"]
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(toggleLeftMenu)];
    
    nav.navigationBar.topItem.leftBarButtonItem = btn;
    [controller toggleLeftSideMenuCompletion:^{}];
}
- (IBAction)aboutButtonPressed:(id)sender {
    MFSideMenuContainerViewController *controller = (MFSideMenuContainerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)controller.centerViewController;
    AboutViewController *avc = [AboutViewController new];
    avc.title = @"About";
    [nav setViewControllers:[NSArray arrayWithObject:avc] animated:NO];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"]
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(toggleLeftMenu)];
    
    nav.navigationBar.topItem.leftBarButtonItem = btn;
    [controller toggleLeftSideMenuCompletion:^{}];
}

-(void)toggleLeftMenu
{
    MFSideMenuContainerViewController *controller = (MFSideMenuContainerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [controller toggleLeftSideMenuCompletion:^{}];
}

@end

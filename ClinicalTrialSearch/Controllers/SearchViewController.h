//
//  SearchViewController.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *diseases;
@property (nonatomic, strong) NSMutableArray *trials;
@property (nonatomic, strong) MFSideMenuContainerViewController *menuContainerViewController;
@property BOOL inDiseaseSearch;

-(void)switchToTrialLookUp;
-(void)switchToDiseaseLookUp;

@end

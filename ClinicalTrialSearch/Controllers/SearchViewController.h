//
//  SearchViewController.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *diseases;
@property (nonatomic, strong) NSMutableArray *trials;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

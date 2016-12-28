//
//  DiseaseDetailViewController.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disease.h"

@interface DiseaseDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) Disease *disease;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

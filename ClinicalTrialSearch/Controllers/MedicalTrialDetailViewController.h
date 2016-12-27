//
//  MedicalTrialDetailViewController.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalTrial.h"

@interface MedicalTrialDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) MedicalTrial *trial;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

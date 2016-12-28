//
//  MedicalTrialOutcome.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 28/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalTrialOutcome : NSObject

@property (strong, nonatomic) NSString *desc;
@property BOOL safetyIssue;
@property (strong, nonatomic) NSString *measure;
@property (strong, nonatomic) NSString *outcomeType;
@property (strong, nonatomic) NSString *timeFrame;

@end
